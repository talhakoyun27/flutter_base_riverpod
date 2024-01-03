import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';
import 'package:flutter_base_riverpod/controller/auth_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    locator<AuthController>().getUserInfo();
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
