import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/theme/custom_color_scheme.dart';
import 'package:flutter_base_riverpod/_library/theme/custom_theme.dart';

/// Custom light theme for project design
final class CustomDarkTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomColorScheme.darkColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        textTheme: textThemeData,
      );

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData =
      const FloatingActionButtonThemeData();

  @override
  TextTheme get textThemeData => TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: CustomColorScheme.darkColorScheme.onPrimary,
        ),
      );
}
