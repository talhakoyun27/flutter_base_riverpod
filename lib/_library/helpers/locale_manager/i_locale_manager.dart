import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_with_value_param.dart';

abstract class ILocalManager {
  Future<Either<Failure, String>> getDataFromKey(LocalKeyParam param);
  Future<Either<Failure, void>> removeDataFromKey(LocalKeyParam param);
  Future<Either<Failure, void>> saveDataFromKey(LocalKeyWithValueParam param);
}
