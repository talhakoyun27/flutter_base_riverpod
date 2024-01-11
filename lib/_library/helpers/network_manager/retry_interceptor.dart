import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (_shouldRetry(err)) {
        return requestRetrier.scheduleRequestRetry(err.requestOptions);
      }
    } catch (exception) {
      return exception;
    }
    return err;
  }

  bool _shouldRetry(DioException err) =>
      err.type == DioExceptionType.connectionError &&
      err.error != null &&
      err.error.runtimeType == SocketException;
}
