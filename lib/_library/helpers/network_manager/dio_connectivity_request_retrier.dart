import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/helpers/connectivity_management.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final NetworkChangeManager connectivity;

  DioConnectivityRequestRetrier(
      {required this.dio, required this.connectivity});

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    final responseCompleter = Completer<Response>();
    connectivity.handleNetworkChange((result) {
      if (result == NetworkResult.on) {
        responseCompleter.complete(
          dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
          ),
        );
      }
    });
    return responseCompleter.future;
  }
}
