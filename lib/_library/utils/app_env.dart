import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static String get fileName => kDebugMode ? ".env.dev" : ".env.prod";

  static String get mode => dotenv.get('MODE', fallback: 'MODE not found');
  static String get sentryDsn =>
      dotenv.get('SENTRY_DSN', fallback: 'SENTRY_DSN not found');
  static String get oneSignalKey =>
      dotenv.get('ONE_SIGNAL_KEY', fallback: 'ONE_SIGNAL_KEY not found');
  static String get baseUrl =>
      dotenv.get('BASE_URL', fallback: 'BASE_URL not found');
}
