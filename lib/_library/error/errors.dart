import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/extensions/string_extension.dart';
import 'package:flutter_base_riverpod/_library/helpers/translation/locale_keys.g.dart';

class LocationError extends Failure {
  LocationError({String? errorText}) : super(errorText: errorText);

  @override
  String get message =>
      (errorText ?? LocaleKeys.error_locationError.tr()).getValueOrDefault;
}

class VersionError extends Failure {
  VersionError({String? errorText}) : super(errorText: errorText);

  @override
  String get message =>
      (errorText ?? LocaleKeys.error_versionError.tr()).getValueOrDefault;
}
