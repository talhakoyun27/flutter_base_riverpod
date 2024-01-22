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
  TextTheme get textThemeData => TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: CustomColorScheme.lightColorScheme.onPrimary,
        ),
      );
}
