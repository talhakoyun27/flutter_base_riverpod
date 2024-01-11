import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/helpers/url_launcher_helper.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/_library/widgets/loader.dart';
import 'package:flutter_base_riverpod/controller/version_controller.dart';
import 'package:flutter_base_riverpod/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VersionControlView extends ConsumerStatefulWidget {
  const VersionControlView({Key? key}) : super(key: key);

  @override
  ConsumerState<VersionControlView> createState() => _VersionControlViewState();
}

class _VersionControlViewState extends ConsumerState<VersionControlView> {
  @override
  void initState() {
    super.initState();
    ref.read(versionProvider).fetchVersion();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(versionProvider);
    switch (controller.versionState.status) {
      case UIStateStatus.loading:
        //loading
        return loadingWidget;

      case UIStateStatus.success:
        //available
        if (controller.versionStatus == AppVersionStatus.usable) {
          return successWidget(controller);
        } else {
          //must be updated
          return mustBeUpdatedWidget(controller.versionState.data?.url ?? "");
        }

      case UIStateStatus.error:
        //unavailable
        return unavailableWidget(controller);

      case UIStateStatus.idle:
        return idleWidget;
    }
  }

  Widget loadingWidget = const Center(child: Loader());

  Widget successWidget(VersionController controller) => Center(
        child: SizedBox(
          child: Text(
            controller.versionState.data!.message,
          ),
        ),
      );

  Widget unavailableWidget(VersionController controller) => Center(
        child: Text(
          controller.versionState.failure!.message,
        ),
      );

  Widget mustBeUpdatedWidget(String url) => Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          Text(
            LocaleKeys.error_mustBeUpdated.tr(),
          ),
          TextButton(
            onPressed: () => openAppInMarket(url),
            child: Text(
              LocaleKeys.button_update.tr(),
            ),
          ),
        ],
      );

  Widget idleWidget = const Center(
    child: Loader(),
  );

  void openAppInMarket(String url) {
    UrlLauncherHelper().launchLinkUrl(
      url: url,
    );
  }
}
