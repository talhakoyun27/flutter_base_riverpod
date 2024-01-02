import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/local_key_with_value_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/i_locale_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';

class SaveDataFromKeyUsecase implements IUsecase<void, LocalKeyWithValueParam> {
  final ILocalManager _localDataSource;

  SaveDataFromKeyUsecase(this._localDataSource);

  @override
  Future<Either<Failure, void>> call(LocalKeyWithValueParam param) async {
    return await _localDataSource.saveDataFromKey(param);
  }
}
