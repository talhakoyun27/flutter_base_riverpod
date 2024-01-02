import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/i_locale_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';

class RemoveDataFromKeyUsecase implements IUsecase<void, LocalKeyParam> {
  final ILocalManager _localDataSource;

  RemoveDataFromKeyUsecase(this._localDataSource);

  @override
  Future<Either<Failure, void>> call(LocalKeyParam param) async {
    return await _localDataSource.removeDataFromKey(param);
  }
}
