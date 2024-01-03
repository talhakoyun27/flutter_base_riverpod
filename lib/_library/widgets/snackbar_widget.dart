import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
// import 'package:flutter_base_riverpod/_library/utils/screen_size.dart';

@immutable
final class CustomSnackbar {
  const CustomSnackbar._();

  static void showSnackBar(
      {required String message,
      required Color bgColor,
      int? second,
      ShapeBorder? shape}) {
    ScaffoldMessenger.of(rootNavigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: Duration(seconds: second ?? 3),
        shape: shape,
        behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.only(
        //   bottom: ScreenSize().screenSize.height / 2,
        //   left: ScreenSize().screenSize.height * 0.01,
        //   right: ScreenSize().screenSize.height * 0.01,
        // ),
      ),
    );
  }
}
