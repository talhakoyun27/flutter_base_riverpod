import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/locale_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/locale_key_with_value_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/locale_manager.dart';

class ThemeState extends ChangeNotifier {
  var isDarkModeEnabled = false;

  ThemeState() {
    getTheme();
  }
  void getTheme() async {
    var result = await LocaleManager()
        .getDataFromKey(LocaleKeyParam(LocalKeys.isDarkModeEnabled));
    result.fold((l) {
      isDarkModeEnabled = false;
    }, (r) {
      isDarkModeEnabled = r == "true";
    });
    notifyListeners();
  }

  void setLightTheme() async {
    isDarkModeEnabled = false;
    await LocaleManager().saveDataFromKey(
        LocaleKeyWithValueParam(LocalKeys.isDarkModeEnabled, data: "false"));

    notifyListeners();
  }

  void setDarkTheme() async {
    isDarkModeEnabled = true;
    await LocaleManager().saveDataFromKey(
        LocaleKeyWithValueParam(LocalKeys.isDarkModeEnabled, data: "true"));
    notifyListeners();
  }
}
