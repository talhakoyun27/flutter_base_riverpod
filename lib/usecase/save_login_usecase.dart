import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_authentication_service.dart';

class SaveLoginUsecase implements IUsecase<void, LogInArgument> {
  final IAuthenticationService _authService;

  SaveLoginUsecase(this._authService);

  @override
  Future<Either<Failure, void>> call(LogInArgument argument) async {
    return await _authService.saveLogInInfo(argument: argument);
  }
}
