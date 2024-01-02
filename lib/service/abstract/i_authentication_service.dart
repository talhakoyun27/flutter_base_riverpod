import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/model/user.dart';

abstract class IAuthenticationService {
  Future<Either<Failure, User>> logIn({required LogInArgument argument});
  Future<Either<Failure, void>> saveLogInInfo(
      {required LogInArgument argument});
  Future<Either<Failure, LogInArgument>> getLogInInfo();
  Future<Either<Failure, void>> removeUserInfo();
}
