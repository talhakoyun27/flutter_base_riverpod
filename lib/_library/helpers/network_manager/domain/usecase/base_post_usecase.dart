import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/injection.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/post_request_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/service/i_network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/controller/authentication.dart';

class BasePostUsecase implements IUsecase<String, PostRequestParam> {
  late final INetworkManager _networkManager;

  BasePostUsecase(this._networkManager);

  @override
  Future<Either<Failure, String>> call(PostRequestParam params) async {
    final token = serviceLocator<Authentication>().currentUser.data?.token;
    return await _networkManager.basePost(
      endPoint: params.endPoint,
      requestBody: params.requestBody,
      queryParameters: params.queryParameters,
      options: token != null
          ? Options(
              headers: {"Authorization": "Bearer $token"},
            )
          : null,
    );
  }
}
