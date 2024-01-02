import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/controller/authentication.dart';
import 'package:flutter_base_riverpod/_library/error/data/manager/exception_logger_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/i_locale_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/locale_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/usecase/get_data_from_key_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/usecase/remove_data_from_key_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/usecase/save_data_from_key_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/service/network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/dio_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/service/i_network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_get_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_post_usecase.dart';
import 'package:flutter_base_riverpod/controller/posts_controller.dart';
import 'package:flutter_base_riverpod/service/abstract/i_authentication_service.dart';
import 'package:flutter_base_riverpod/service/abstract/i_post_service.dart';
import 'package:flutter_base_riverpod/service/authentication_service.dart';
import 'package:flutter_base_riverpod/service/posts_service.dart';
import 'package:flutter_base_riverpod/usecase/get_login_argument_usecase.dart';
import 'package:flutter_base_riverpod/usecase/login_usecase.dart';
import 'package:flutter_base_riverpod/usecase/posts_usecase.dart';
import 'package:flutter_base_riverpod/usecase/save_login_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_base_riverpod/_library/helpers/device_manager.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {

  serviceLocator
      .registerLazySingleton<SaveLoginUsecase>(() => SaveLoginUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  serviceLocator.registerLazySingleton<Connectivity>(() => Connectivity());
  serviceLocator.registerLazySingleton<Dio>(() => DioManager.getDio());
  serviceLocator.registerSingletonAsync<DeviceManager>(
      () async => await DeviceManager.createDeviceInfo());

  serviceLocator.registerLazySingleton(() => ExceptionLoggerManager());

  serviceLocator.registerLazySingleton<BaseGetUsecase>(
      () => BaseGetUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<BasePostUsecase>(
      () => BasePostUsecase(serviceLocator()));

  serviceLocator.registerLazySingleton<ILocalManager>(
      () => LocalManager(serviceLocator()));

  serviceLocator.registerLazySingleton<GetDataFromKeyUsecase>(
      () => GetDataFromKeyUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<RemoveDataFromKeyUsecase>(
      () => RemoveDataFromKeyUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<SaveDataFromKeyUsecase>(
      () => SaveDataFromKeyUsecase(serviceLocator()));

  serviceLocator.registerLazySingleton<IAuthenticationService>(
    () => AuthenticationService(
      basePostUsecase: serviceLocator(),
      getDataFromKeyUsecase: serviceLocator(),
      saveDataFromKeyUsecase: serviceLocator(),
      removeDataFromKeyUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<IPostsService>(
    () => PostsService(
      baseGetUsecase: serviceLocator(),
      basePostUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<GetLogInArgumentUsecase>(
      () => GetLogInArgumentUsecase(serviceLocator()));

  serviceLocator.registerLazySingleton<Authentication>(
    () => Authentication(
      serviceLocator(),
      logInUsecase: serviceLocator(),
      getLogInArgumentUsecase: serviceLocator(),
      saveUsecase: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<PostsService>(() => PostsService(
      baseGetUsecase: serviceLocator(), basePostUsecase: serviceLocator()));

  serviceLocator.registerLazySingleton<INetworkManager>(
    () => NetworkManager(serviceLocator<Dio>()),
  );
  // USECASES
  serviceLocator.registerLazySingleton<LogInUsecase>(
      () => LogInUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton<PostsUseCase>(
      () => PostsUseCase(serviceLocator()));

  serviceLocator.registerLazySingleton<PostsController>(() => PostsController(
      postsUseCase: serviceLocator(), postsService: serviceLocator()));
}
