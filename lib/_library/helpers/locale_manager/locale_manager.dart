import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_with_value_param.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/i_locale_manager.dart';

class LocalManager implements ILocalManager {
  final FlutterSecureStorage secureStorage;

  LocalManager(this.secureStorage);

  @override
  Future<Either<Failure, String>> getDataFromKey(LocalKeyParam param) async {
    String? value = await secureStorage.read(key: param.key.value);
    if (value != null) {
      return Right(value);
    } else {
      return Left(NullPointerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeDataFromKey(LocalKeyParam param) async {
    try {
      await secureStorage.delete(key: param.key.value);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> saveDataFromKey(
      LocalKeyWithValueParam param) async {
    try {
      await secureStorage.write(key: param.key.value, value: param.data);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
