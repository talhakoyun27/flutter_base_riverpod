import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';
import 'package:flutter_base_riverpod/controller/auth_controller.dart';
import 'package:flutter_base_riverpod/controller/version_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    controls();
  }

  controls() async {
    UIState<VersionControlModel> versionState =
        await locator<VersionController>().fetchVersion();
    switch (versionState.data?.status ?? AppVersionStatus.unavailable) {
      case AppVersionStatus.usable:
        locator<AuthController>().getUserInfo();
        break;
      case AppVersionStatus.mustBeUpdated:
        myRouter.goNamed("version_update", extra: versionState.data);
        break;
      case AppVersionStatus.unavailable:
        myRouter.goNamed("version_error", extra: versionState.data);
        break;
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ScreenSize().screenSize = MediaQuery.of(context).size;
    return AppScaffold(
      body: Center(
        child: Text(LocaleKeys.mainText_title.tr()),
      ),
    );
  }
}
