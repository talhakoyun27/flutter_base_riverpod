import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
import 'package:flutter_base_riverpod/app.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/translation_manager.dart';
import 'package:flutter_base_riverpod/_library/utils/app_env.dart';
import 'package:flutter_base_riverpod/_library/utils/push_notification_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    initLocators(),
    dotenv.load(fileName: AppEnvironment.fileName),
  ]);
  PushNotificationManager.initializePushNotification();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SentryFlutter.init(
    (options) {
      options
        ..dsn = AppEnvironment.sentryDsn
        ..tracesSampleRate = 1.0
        ..environment = AppEnvironment.mode;
    },
    appRunner: () {
      runApp(
        ProviderScope(
          child: TranslationManager(
            child: const BaseApp(),
          ),
        ),
      );
    },
  );
}
