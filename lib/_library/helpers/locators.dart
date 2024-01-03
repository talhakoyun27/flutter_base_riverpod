import 'package:flutter_base_riverpod/controller/auth_controller.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/locale_manager.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
Future<void> initLocators() async {
  locator.registerLazySingleton(() => LocaleManager());
  locator.registerLazySingleton<AuthController>(() => AuthController());
}
