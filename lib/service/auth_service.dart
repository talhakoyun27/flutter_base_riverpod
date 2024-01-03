import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/error/failure/network_failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/model/item_base_model.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/service/network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/dio_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/model/user.dart';
import 'package:flutter_base_riverpod/service/abstract/i_auth_service.dart';

class AuthService extends IAuthService {
  NetworkManager networkManager = NetworkManager(DioManager.getDio());
  @override
  Future<Either<Failure, User>> login(LogInArgument argument) async {
    try {
      var response = await networkManager.basePost(
          endPoint: AppEndpoint.login, requestBody: argument.toMap());
      return response.fold(
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
  register(String mail, String password) {}
}
