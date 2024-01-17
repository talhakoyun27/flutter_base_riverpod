import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/device_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
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
  UIState<VersionControlModel> versionState = UIState.idle();

  Future<UIState<VersionControlModel>> fetchVersion() async {
    versionState = UIState.loading();
    refreshView();
    final fetchVersionEither = await VersionService().fetchVersion(
        params: GetRequestParam(endPoint: AppEndpoint.fetchVersion));
    await fetchVersionEither.fold(
      (failure) {
        versionState = UIState.error(failure);
      },
      (data) async {
        versionStatus = await _checkStatus(data);
        switch (versionStatus) {
          case AppVersionStatus.usable:
            VersionControlModel result = VersionControlModel(
              status: AppVersionStatus.usable,
              message:
                  data.android?.message ?? LocaleKeys.general_appIsUsable.tr(),
            );
            versionState = UIState.success(result);

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

          case AppVersionStatus.unavailable:
            VersionControlModel result = VersionControlModel(
              status: AppVersionStatus.unavailable,
              message: platform == AppPlatform.android
                  ? data.android?.message ??
                      LocaleKeys.error_maintenanceBody.tr()
                  : platform == AppPlatform.ios
                      ? data.ios?.message ??
                          LocaleKeys.error_maintenanceBody.tr()
                      : LocaleKeys.error_maintenanceBody.tr(),
            );
            versionState = UIState.success(result);
        }
      },
    );
    refreshView();
    return versionState;
  }

  // Başlangıç noktası
  Future<AppVersionStatus> _checkStatus(VersionModel model) async {
    return _checkPlatformStatus(model);
  }

  // Yüklü uygulama ios versiyonu güncel mi kontrol et
  AppVersionStatus _checkIosVersion(VersionModel? model) {
    int parsedVersion = _parseVersion();
    if (parsedVersion >= (model?.ios?.version ?? 0)) {
      // Uygulama kullanılabilir
      return AppVersionStatus.usable;
    } else {
      // Uygulama güncellenmek zorunda
      platform = AppPlatform.ios;
      return AppVersionStatus.mustBeUpdated;
    }
  }

// Yüklü uygulama android versiyonu güncel mi kontrol et
  AppVersionStatus _checkAndroidVersion(VersionModel? model) {
    int parsedVersion = _parseVersion();
    if (parsedVersion >= (model?.android?.version ?? 0)) {
      // Uygulama kullanılabilir
      return AppVersionStatus.usable;
    } else {
      // uygulama güncellenmek zorunda
      platform = AppPlatform.android;
      return AppVersionStatus.mustBeUpdated;
    }
  }

  // Uygulama ios cihazlarda kullanılabilir mi
  AppVersionStatus _checkIosUseable(VersionModel? model) {
    if (model?.ios?.usable ?? false) {
      return _checkIosVersion(model);
    } else {
      // Kullanılamaz
      return AppVersionStatus.unavailable;
    }
  }

  // Uygulama android cihazlarda kullanılabilir mi
  AppVersionStatus _checkAndroidUseable(VersionModel? model) {
    if (model?.android?.usable ?? false) {
      return _checkAndroidVersion(model);
    } else {
      // Kullanılamaz
      return AppVersionStatus.unavailable;
    }
  }

  // Platformu kontrol et
  Future<AppVersionStatus> _checkPlatformStatus(VersionModel? model) async {
    if (locator<DeviceManager>().isAndroid) {
      return _checkAndroidUseable(model);
    } else if (locator<DeviceManager>().isIos) {
      return _checkIosUseable(model);
    } else {
      // Android veya ios değilse kullanılamaz
      return AppVersionStatus.usable;
    }
  }

  // Yüklü uygulama versiyonunu parse et
  int _parseVersion() {
    return int.tryParse(
            locator<DeviceManager>().appVersion.split('.').join()) ??
        0;
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
