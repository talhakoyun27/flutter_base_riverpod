import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/error/failure/network_failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_with_value_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_keys.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/usecase/get_data_from_key_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/usecase/remove_data_from_key_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/usecase/save_data_from_key_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/dto/item_base_model.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/post_request_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_post_usecase.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/model/user.dart';
import 'package:flutter_base_riverpod/service/abstract/i_authentication_service.dart';

class AuthenticationService implements IAuthenticationService {
  final BasePostUsecase basePostUsecase;
  final SaveDataFromKeyUsecase saveDataFromKeyUsecase;
  final GetDataFromKeyUsecase getDataFromKeyUsecase;
  final RemoveDataFromKeyUsecase removeDataFromKeyUsecase;

  AuthenticationService({
    required this.basePostUsecase,
    required this.saveDataFromKeyUsecase,
    required this.getDataFromKeyUsecase,
    required this.removeDataFromKeyUsecase,
  });

  @override
  Future<Either<Failure, LogInArgument>> getLogInInfo()async {
    try {
      final logInEither = await getDataFromKeyUsecase(
        LocalKeyParam(LocalKeys.loginInfo),
      );

      return logInEither.fold(
        (failure) => Left(failure),
        (data) {
          LogInArgument loginArgument = LogInArgument.fromJson(data);
          return Right(loginArgument);
        },
      );
    } catch (_) {
      return Left(ServiceFailure());
    }
  }

  @override
  Future<Either<Failure, User>> logIn({required LogInArgument argument}) async {
    try {
      final logInEither = await basePostUsecase(
        PostRequestParam(
          endPoint: AppEndpoint.login,
          requestBody: argument.toMap(),
        ),
      );
      return logInEither.fold(
        (failure) => Left(failure),
        (data) {
          if (!json.decode(data)["status"]) {
            return Left(NotFoundFailure(errorText: "Kullanıcı bulunamadı."));
          }
          ItemBaseModel<User> userItemBaseModel =
              ItemBaseModel<User>.fromJson(data, User.fromMap);
          return Right(userItemBaseModel.data);
        },
      );
    } catch (e) {
      return Left(ServiceFailure(errorText: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeUserInfo() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveLogInInfo(
      {required LogInArgument argument}) async {
    try {
      final logInEither = await saveDataFromKeyUsecase(
        LocalKeyWithValueParam(LocalKeys.loginInfo, data: argument.toJson()),
      );

      return logInEither.fold(
        (failure) => Left(failure),
        (data) => const Right(null),
      );
    } catch (_) {
      return Left(ServiceFailure());
    }
  }
}
