import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/injection.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/service/i_network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/controller/authentication.dart';

class BaseGetUsecase implements IUsecase<String, GetRequestParam> {
  late final INetworkManager _networkManager;

  BaseGetUsecase(this._networkManager);

  @override
  Future<Either<Failure, String>> call(GetRequestParam params) async {
    final token = serviceLocator<Authentication>().currentUser.data?.token;
    return await _networkManager.baseGet(
      endPoint: params.endPoint,
      queryParameters: params.queryParameters,
      slug: params.slug,
      options: token != null
          ? Options(
              headers: {"Authorization": "Bearer $token"},
            )
          : null,
    );
  }
}
