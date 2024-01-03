
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';

class GetRequestParam {
  final AppEndpoint endPoint;
  final Map<String, dynamic>? queryParameters;
  final String? slug;

  GetRequestParam({required this.endPoint, this.queryParameters, this.slug});
}
