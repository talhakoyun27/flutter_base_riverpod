import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';
import 'package:flutter_base_riverpod/_library/theme/controller/theme_state.dart';
import 'package:flutter_base_riverpod/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeViewState();
}

class _ThemeViewState extends ConsumerState<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(appThemeStateNotifier);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildThemeChanged(appTheme),
          buildLangChanged(context),
        ],
      ),
    );
  }

  Widget buildThemeChanged(ThemeState appTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LocaleKeys.button_themeChange.tr(),
            style: Theme.of(context).textTheme.bodyMedium!),
        Switch(
            value: appTheme.isDarkModeEnabled,
            onChanged: (enable) {
              if (enable) {
                appTheme.setDarkTheme();
              } else {
                appTheme.setLightTheme();
              }
            })
      ],
    );
  }

  Widget buildLangChanged(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5),
      ),
      onPressed: () {
        context.locale == const Locale('en', 'US')
            ? context.setLocale(const Locale('tr', 'TR'))
            : context.setLocale(const Locale('en', 'US'));
      },
      child: Text(
        LocaleKeys.button_languageChange.tr(),
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
    );
  }
}
