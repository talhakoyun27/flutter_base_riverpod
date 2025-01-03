import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/constants/app_constants.dart';
import 'package:flutter_base_riverpod/_library/helpers/connectivity_management.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/dio_connectivity_request_retrier.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/retry_interceptor.dart';

class DioManager {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = AppConstants().baseUrl;

    dio.options.headers = {
      "Accept": "application/json",
    };

    dio.options.queryParameters = {
      //Seçili lokal dil bilgisi buraya geçilecek.
      // "lang": "TR",
    };

    dio.options.responseType = ResponseType.plain;
    dio.options.validateStatus = (_) => true;

    //Refresh Token için interceptor yazılacak.

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: NetworkChangeManager(),
        ),
      ),
    );

    dio.interceptors.add(
        LogInterceptor(requestBody: true, error: true, responseBody: true));
    return dio;
  }
}
