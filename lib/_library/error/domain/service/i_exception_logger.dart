abstract class IExceptionLogger {
  Future<void> captureException(dynamic exception, {StackTrace? stackTrace, Map<String, dynamic>? extra});
  Future<void> captureInfoMessage(String message, {Map<String, dynamic>? extra});
}
