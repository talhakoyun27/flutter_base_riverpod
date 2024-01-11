import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/device_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/controller/base_controller.dart';
import 'package:flutter_base_riverpod/model/version_model.dart';
import 'package:flutter_base_riverpod/service/version_service.dart';
import 'package:easy_localization/easy_localization.dart';

class VersionController extends BaseController {
  VersionController();
  AppVersionStatus versionStatus = AppVersionStatus.unavailable;
  AppPlatform? platform;
  String? downloadedVersion;
  UIState<VersionControlModel> versionState = UIState.idle();

  Future<void> fetchVersion() async {
    downloadedVersion = await _getDeviceAppVersion();

    versionState = UIState.loading();
    refreshView();
    final fetchVersionEither = await VersionService().fetchVersion(
        params: GetRequestParam(endPoint: AppEndpoint.fetchVersion));
    fetchVersionEither.fold(
      (failure) {
        versionState = UIState.error(failure);
      },
      (data) async {
        versionStatus = await _checkStatus(data);
        switch (versionStatus) {
          case AppVersionStatus.usable:
            VersionControlModel result = VersionControlModel(
                status: AppVersionStatus.usable,
                message: data.android?.message ??
                    LocaleKeys.general_appIsUsable.tr());
            versionState = UIState.success(result);
            break;

          case AppVersionStatus.mustBeUpdated:
            VersionControlModel result = VersionControlModel(
              status: AppVersionStatus.mustBeUpdated,
              message: LocaleKeys.error_mustBeUpdated.tr(),
              url: platform == AppPlatform.android
                  ? data.android?.link ?? ""
                  : platform == AppPlatform.ios
                      ? data.ios?.link ?? ""
                      : "",
              platform: platform,
            );
            versionState = UIState.success(result);
            break;

          case AppVersionStatus.unavailable:
            VersionControlModel result = VersionControlModel(
                status: AppVersionStatus.unavailable,
                message:
                    data.android?.message ?? LocaleKeys.error_notAvaible.tr());
            versionState = UIState.error(result);
            break;
        }
        refreshView();
      },
    );
    refreshView();
  }

  // Get version of the downloaded app
  Future<String> _getDeviceAppVersion() async {
    DeviceManager deviceManager = await DeviceManager.createDeviceInfo();
    String currentAppVersion = deviceManager.appVersion;
    return currentAppVersion;
  }

  // Check if app is active
  Future<AppVersionStatus> _checkStatus(VersionModel model) async {
    return _checkPlatformStatus(model);
  }

  // Check if downloaded ios app is updated
  AppVersionStatus _checkIosVersion(VersionModel? model) {
    int parsedVersion = _parseVersion();
    if (parsedVersion >= (model?.ios?.version ?? 0)) {
      // App can be used
      return AppVersionStatus.usable;
    } else {
      //must be updated
      platform = AppPlatform.ios;
      return AppVersionStatus.mustBeUpdated;
    }
  }

// Check if downloaded android app is updated
  AppVersionStatus _checkAndroidVersion(VersionModel? model) {
    int parsedVersion = _parseVersion();
    if (parsedVersion >= (model?.android?.version ?? 0)) {
      // App can be used
      return AppVersionStatus.usable;
    } else {
      // App must be updated
      platform = AppPlatform.android;
      return AppVersionStatus.mustBeUpdated;
    }
  }

  // Check if app is useable for ios platform
  AppVersionStatus _checkIosUseable(VersionModel? model) {
    if (model?.ios?.usable ?? false) {
      return _checkIosVersion(model);
    } else {
      // App is closed for ios
      return AppVersionStatus.unavailable;
    }
  }

  // Check if app is useable for android platform
  AppVersionStatus _checkAndroidUseable(VersionModel? model) {
    if (model?.android?.usable ?? false) {
      return _checkAndroidVersion(model);
    } else {
      // App is closed for android
      return AppVersionStatus.unavailable;
    }
  }

  // Get platform and check if useable
  Future<AppVersionStatus> _checkPlatformStatus(VersionModel? model) async {
    DeviceManager deviceManager = await DeviceManager.createDeviceInfo();
    if (deviceManager.isAndroid) {
      return _checkAndroidUseable(model);
    } else if (deviceManager.isIos && model!.android != null) {
      return _checkIosUseable(model);
    } else {
      // Android veya ios değilse
      return AppVersionStatus.usable;
    }
  }

  // Parse string downloaded app version to int
  int _parseVersion() {
    return int.tryParse(downloadedVersion?.split('.').join() ?? "0") ?? 0;
  }
}

class VersionControlModel extends Failure {
  AppVersionStatus status;
  @override
  String message;
  String? url;
  AppPlatform? platform;
  VersionControlModel(
      {required this.status, required this.message, this.url, this.platform});
}

enum AppPlatform { ios, android }

enum AppVersionStatus { usable, mustBeUpdated, unavailable }
