import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';

abstract class INetworkManager {
  Future<Either<Failure, String>> baseGet({
    required AppEndpoint endPoint,
    Map<String, dynamic>? queryParameters,
    String? slug,
    Options? options,
  });

  Future<Either<Failure, String>> basePost({
    required Map<String, dynamic> requestBody,
    required AppEndpoint endPoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}
