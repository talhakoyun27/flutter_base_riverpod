import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/extensions/string_extension.dart';

class LocationError extends Failure {
  LocationError({String? errorText}) : super(errorText: errorText);

  @override
  String get message => (errorText??"").getValueOrDefault;
}
