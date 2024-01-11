import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/model/item_base_model.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/service/network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/dio_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/model/version_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_version_service.dart';

class VersionService implements IVersionService {
  NetworkManager networkManager = NetworkManager(DioManager.getDio());

  VersionService();
  @override
  Future<Either<Failure, VersionModel>> fetchVersion(
      {required GetRequestParam params}) async {
    try {
      final fetchPostsEither = await networkManager.baseGet(
          endPoint: params.endPoint, queryParameters: params.queryParameters);
      return fetchPostsEither.fold((failure) => Left(failure), (data) {
        ItemBaseModel<VersionModel> itemBaseModel =
            ItemBaseModel<VersionModel>.fromJson(data, VersionModel.fromMap);
        final posts = itemBaseModel.data;
        return Right(posts);
      });
    } catch (e) {
      return Left(ServiceFailure(errorText: e.toString()));
    }
  }
}
