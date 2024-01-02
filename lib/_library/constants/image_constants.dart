import 'package:flutter/foundation.dart';

@immutable
final class ImageConstants {
  const ImageConstants._();

  //kullanımına ait örnek
  static final String icGithub = 'ic_github'.toImgPng;
}

extension on String {
  String get toImgPng => 'assets/images/$this.png';
}
