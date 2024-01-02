import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/model/user.dart';
import 'package:flutter_base_riverpod/service/abstract/i_authentication_service.dart';

class LogInUsecase implements IUsecase<User, LogInArgument> {
  final IAuthenticationService _authenticationService;

  LogInUsecase(this._authenticationService);

  @override
  Future<Either<Failure, User>> call(LogInArgument argument) async {
    return await _authenticationService.logIn(argument: argument);
  }
}
