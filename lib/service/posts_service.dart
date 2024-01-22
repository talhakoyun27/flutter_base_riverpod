import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/model/list_base_model.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/service/network_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/dio_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/controller/auth_controller.dart';
import 'package:flutter_base_riverpod/model/posts_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_post_service.dart';

class PostsService implements IPostsService {
  NetworkManager networkManager = NetworkManager(DioManager.getDio());

  PostsService();
  @override
  Future<Either<Failure, List<PostModel>>> fetchPosts(
      GetRequestParam params) async {
    final token = locator<AuthController>().currentUser.data?.token;
    try {
      final fetchPostsEither = await networkManager.baseGet(
          endPoint: params.endPoint,
          queryParameters: params.queryParameters,
          options: token != null
              ? Options(
                  headers: {"Authorization": "Bearer $token"},
                )
              : null);
      return fetchPostsEither.fold((failure) => Left(failure), (data) {
        ListBaseModel<PostModel> postListBaseModel =
            ListBaseModel<PostModel>.fromJson(data, PostModel.fromMap);
        final posts = postListBaseModel.data;
        return Right(posts);
      });
    } catch (e) {
      return Left(ServiceFailure(errorText: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> fetchPostDetail({required int id}) {
    throw UnimplementedError();
  }
}
