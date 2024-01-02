// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/widgets/snackbar_widget.dart';

enum CustomMessageEnum {
  SUCCESS,
  INFO,
  WARNING,
  ERROR,
}

extension CustomMessengerHelper on CustomMessageEnum {
  Color getColor() {
    switch (this) {
      case CustomMessageEnum.SUCCESS:
        return Colors.green;
      case CustomMessageEnum.INFO:
        return Colors.blue;
      case CustomMessageEnum.WARNING:
        return Colors.orange;
      case CustomMessageEnum.ERROR:
        return Colors.red;
    }
  }

  Color getIconColor() {
    switch (this) {
      case CustomMessageEnum.SUCCESS:
        return Colors.white;
      case CustomMessageEnum.INFO:
        return Colors.white;
      case CustomMessageEnum.WARNING:
        return Colors.white;
      case CustomMessageEnum.ERROR:
        return Colors.white;
    }
  }

  Color getTextColor() {
    switch (this) {
      case CustomMessageEnum.SUCCESS:
        return Colors.white;
      case CustomMessageEnum.INFO:
        return Colors.white;
      case CustomMessageEnum.WARNING:
        return Colors.white;
      case CustomMessageEnum.ERROR:
        return Colors.white;
    }
  }

  IconData getIcon() {
    switch (this) {
      case CustomMessageEnum.SUCCESS:
        return Icons.check_circle;
      case CustomMessageEnum.INFO:
        return Icons.warning_rounded;
      case CustomMessageEnum.WARNING:
        return Icons.warning_rounded;
      case CustomMessageEnum.ERROR:
        return Icons.warning_rounded;
    }
  }
}

void showCustomMessenger(CustomMessageEnum messengerState, String content,
    {int second = 2}) {
  CustomSnackbar.showSnackBar(
    message: content,
    bgColor: messengerState.getColor(),
    second: second,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(24),
    ),
  );
}
