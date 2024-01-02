import 'package:flutter/foundation.dart';
import 'package:flutter_base_riverpod/_library/error/domain/service/i_exception_logger.dart';

class DebugExceptionLogger implements IExceptionLogger {
  @override
  Future<void> captureException(dynamic exception,
      {StackTrace? stackTrace, Map<String, dynamic>? extra}) async {
    if (kDebugMode) {
      print(exception);
    }
  }

  @override
  Future<void> captureInfoMessage(String message,
      {Map<String, dynamic>? extra}) async {
    if (kDebugMode) {
      print("info: $message");
    }
  }
}
