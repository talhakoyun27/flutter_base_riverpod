import 'package:flutter_base_riverpod/_library/error/domain/service/i_exception_logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryExceptionLogger implements IExceptionLogger {
  @override
  Future<void> captureException(dynamic exception,
      {StackTrace? stackTrace, Map<String, dynamic>? extra}) async {
    await Sentry.captureException(exception, stackTrace: stackTrace,
        withScope: (scope) {
      if (extra != null) {
        for (var element in extra.entries) {
          scope.setExtra(element.key, element.value);
        }
      }
    });
  }

  @override
  Future<void> captureInfoMessage(String message,
      {Map<String, dynamic>? extra}) async {
    await Sentry.captureMessage(message, level: SentryLevel.info,
        withScope: (scope) {
      if (extra != null) {
        for (var element in extra.entries) {
          scope.setExtra(element.key, element.value);
        }
      }
    });
  }
}
