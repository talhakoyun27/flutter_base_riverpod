import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';

class PostRequestParam {
  final AppEndpoint endPoint;
  final Map<String, dynamic> requestBody;
  final Map<String, dynamic>? queryParameters;

  PostRequestParam({
    required this.endPoint,
    required this.requestBody,
    this.queryParameters,
  });
}
