import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';

extension NumExtension on num {
  double get h => ScreenSize().getHeight(this);

  double get w => ScreenSize().getWidth(this);

  double get sp => ScreenSize().getSp(this);

  double get r => ScreenSize().radius(this);

  String toDotFormat() {
    var numberFormat = NumberFormat("#,###.##", "tr");
    return numberFormat.format(this);
  }
}

extension NumNullableExtension on num? {
  bool get isNotNull => this != null;
  num get getValueOrDefault => this ?? 0;
}
