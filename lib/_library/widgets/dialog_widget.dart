import 'package:flutter/material.dart';

enum CustomDialogMessageEnum {
  success,
  info,
  warning,
  error,
}

extension CustomDialogMessengerHelper on CustomDialogMessageEnum {
  Color getColor() {
    switch (this) {
      case CustomDialogMessageEnum.success:
        return Colors.green;
      case CustomDialogMessageEnum.info:
        return Colors.blue;
      case CustomDialogMessageEnum.warning:
        return Colors.yellow;
      case CustomDialogMessageEnum.error:
        return Colors.red;
    }
  }

  Color getIconColor() {
    switch (this) {
      case CustomDialogMessageEnum.success:
        return Colors.white;
      case CustomDialogMessageEnum.info:
        return Colors.white;
      case CustomDialogMessageEnum.warning:
        return Colors.white;
      case CustomDialogMessageEnum.error:
        return Colors.white;
    }
  }

  // eğer text rengi değişecekse buraya eklenebilir.
  Color getTextColor() {
    switch (this) {
      case CustomDialogMessageEnum.success:
        return Colors.white;
      case CustomDialogMessageEnum.info:
        return Colors.white;
      case CustomDialogMessageEnum.warning:
        return Colors.white;
      case CustomDialogMessageEnum.error:
        return Colors.white;
    }
  }

  IconData getIcon() {
    switch (this) {
      case CustomDialogMessageEnum.success:
        return Icons.check_circle_outline;
      case CustomDialogMessageEnum.info:
        return Icons.warning_amber_rounded;
      case CustomDialogMessageEnum.warning:
        return Icons.warning_amber_rounded;
      case CustomDialogMessageEnum.error:
        return Icons.error_outline;
    }
  }
}

void showCustomDialogMessenger(
    {BuildContext? context,
    required CustomDialogMessageEnum messageState,
    String? title,
    String? content}) {
  showDialog(
    context: context!,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      title: Column(
        children: [
          Icon(messageState.getIcon(), color: messageState.getIconColor()),
          Text(
            title!,
            style: TextStyle(color: messageState.getTextColor()),
          ),
        ],
      ),
    ),
  );
}
