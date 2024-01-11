import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/theme/custom_color_scheme.dart';
import 'package:flutter_base_riverpod/_library/theme/custom_theme.dart';

final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorScheme.lightColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        textTheme: textThemeData,
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData();

  @override
  TextTheme get textThemeData => const TextTheme(
        bodyLarge: TextStyle(fontSize: 16),
        labelMedium: TextStyle(fontSize: 14),
      );
}
