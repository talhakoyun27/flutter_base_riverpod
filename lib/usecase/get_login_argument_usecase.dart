import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_authentication_service.dart';

class GetLogInArgumentUsecase implements IUsecase<LogInArgument, NoParams> {
  final IAuthenticationService _authenticationService;

  GetLogInArgumentUsecase(this._authenticationService);

  @override
  Future<Either<Failure, LogInArgument>> call(NoParams _) async {
    return await _authenticationService.getLogInInfo();
  }
}
