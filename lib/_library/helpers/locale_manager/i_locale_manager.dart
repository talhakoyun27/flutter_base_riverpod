import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/locale_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/locale_key_with_value_param.dart';

abstract class ILocaleManager {
  Future<Either<Failure, String>> getDataFromKey(LocaleKeyParam param);
  Future<Either<Failure, void>> removeDataFromKey(LocaleKeyParam param);
  Future<Either<Failure, void>> saveDataFromKey(LocaleKeyWithValueParam param);
}
