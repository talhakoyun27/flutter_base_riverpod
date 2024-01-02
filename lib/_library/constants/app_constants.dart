import 'dart:ui';

import 'package:flutter_base_riverpod/_library/utils/app_env.dart';

class AppConstants {
  static final AppConstants _instance = AppConstants._init();
  AppConstants._init();

  factory AppConstants() {
    return _instance;
  }

  ///Tasarımda bulunan cihazın ekran boyutlarını buraya giriyoruz.
  Size designDeviceSize = const Size(375, 812);

  String baseUrl = AppEnvironment.baseUrl;
  static const String slug = "{slug}";
}
