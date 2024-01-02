import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/injection.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';
import 'package:flutter_base_riverpod/controller/authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    serviceLocator<Authentication>().getUserInfo();
    ScreenSize().screenSize = MediaQuery.of(context).size;
    return Center(
      child: Text(LocaleKeys.mainText_title.tr()),
    );
  }
}
