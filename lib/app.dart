import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/theme/custom_dark_theme.dart';
import 'package:flutter_base_riverpod/_library/theme/custom_light_theme.dart';
import 'package:flutter_base_riverpod/_library/widgets/network_widgets/network_connectivity_build.dart';
import 'package:flutter_base_riverpod/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseApp extends ConsumerWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeMode = ref.watch(appThemeStateNotifier);
    return MaterialApp.router(
      title: LocaleKeys.mainText_title.tr(),
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      builder: NetworkConnectivityBuild.build,
      themeMode: themeMode.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: kDebugMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}
