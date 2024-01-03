import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/constants/app_constants.dart';
import 'package:flutter_base_riverpod/_library/error/exceptions.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/error/failure/network_failure.dart';
import 'package:flutter_base_riverpod/_library/extensions/string_extension.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/service/i_network_manager.dart';

class NetworkManager implements INetworkManager {
  final Dio dio;

  NetworkManager(this.dio);

  @override
  Future<Either<Failure, String>> baseGet({
    required AppEndpoint endPoint,
    Map<String, dynamic>? queryParameters,
    String? slug,
    Options? options,
  }) async {
    return await _errorHandler(
      dio.get(
        endPoint.value
            .replaceAll(AppConstants.slug, (slug ?? "").getValueOrDefault),
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> basePost({
    required Map<String, dynamic> requestBody,
    required AppEndpoint endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _errorHandler(
      dio.post(
        endPoint.value,
        data: jsonEncode(requestBody),
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Either<Failure, String>> _errorHandler(
      Future<Response> requestFunction) async {
    Response response;
    try {
      response = await requestFunction;
    } on SocketException {
      return Left(NoInternetConnectionException());
    }

    return _handleResponse(response);
  }

  Either<Failure, String> _handleResponse(Response response) {
    final json = jsonDecode(response.data);
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.created:
      case HttpStatus.accepted:
      case HttpStatus.noContent:
        return Right(response.data);
      case HttpStatus.badRequest:
        return Left(BadRequestFailure(errorText: json["message"]));
      case HttpStatus.unauthorized:
        return Left(UnauthorizedFailure(errorText: json["message"]));
      case HttpStatus.forbidden:
        return Left(ForbiddenFailure(errorText: json["message"]));
      case HttpStatus.notFound:
        return Left(NotFoundFailure(errorText: json["message"]));
      case HttpStatus.internalServerError:
        return Left(InternalFailure(errorText: json["message"]));
      case HttpStatus.gatewayTimeout:
        return Left(GatewayTimeOutFailure(errorText: json["message"]));
      default:
        return Left(NotFoundFailure(errorText: json["message"]));
    }
  }
}
