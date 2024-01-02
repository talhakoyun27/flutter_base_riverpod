import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';

class NoInternetConnectionException extends Failure {
  NoInternetConnectionException({String? errorText})
      : super(errorText: errorText);
  @override
  String get message => throw UnimplementedError();
}
