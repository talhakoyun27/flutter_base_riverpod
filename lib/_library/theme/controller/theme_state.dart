import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/injection.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_with_value_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_keys.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/i_locale_manager.dart';

class ThemeState extends ChangeNotifier {
  var isDarkModeEnabled = false;

  ThemeState() {
    getTheme();
  }
  void getTheme() async {
    var result = await serviceLocator<ILocalManager>()
        .getDataFromKey(LocalKeyParam(LocalKeys.isDarkModeEnabled));
    result.fold((l) {
      isDarkModeEnabled = false;
      
    }, (r) {
      isDarkModeEnabled = r == "true";
    });
    notifyListeners();
  }

  void setLightTheme() async {
    isDarkModeEnabled = false;
    await serviceLocator<ILocalManager>().saveDataFromKey(
        LocalKeyWithValueParam(LocalKeys.isDarkModeEnabled, data: "false"));

    notifyListeners();
  }

  void setDarkTheme() async {
    isDarkModeEnabled = true;
    await serviceLocator<ILocalManager>().saveDataFromKey(
        LocalKeyWithValueParam(LocalKeys.isDarkModeEnabled, data: "true"));
    notifyListeners();
  }
}
