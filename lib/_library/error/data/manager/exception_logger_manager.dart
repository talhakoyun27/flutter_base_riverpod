
import 'package:flutter_base_riverpod/_library/error/data/service/debug_exception_logger.dart';
import 'package:flutter_base_riverpod/_library/error/data/service/sentry_exception_logger.dart';
import 'package:flutter_base_riverpod/_library/error/domain/service/i_exception_logger.dart';

class ExceptionLoggerManager {
  late List<IExceptionLogger> _loggers;

  ExceptionLoggerManager() {
    _loggers = [
      SentryExceptionLogger(),
      DebugExceptionLogger(),
    ];
  }

  Future<void> captureException(dynamic exception, {StackTrace? stackTrace, Map<String, dynamic>? extra}) async {
    await Future.wait(_loggers.map((item) => item.captureException(exception, stackTrace: stackTrace, extra: extra)).toList());
  }

  Future<void> captureInfoMessage(String message, {Map<String, dynamic>? extra}) async {
    await Future.wait(_loggers.map((item) => item.captureInfoMessage(message, extra: extra)).toList());
  }
}
