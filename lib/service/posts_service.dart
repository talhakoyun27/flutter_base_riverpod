import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/data/dto/list_base_model.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_get_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_post_usecase.dart';
import 'package:flutter_base_riverpod/model/posts_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_post_service.dart';

class PostsService implements IPostsService {
  final BaseGetUsecase baseGetUsecase;
  final BasePostUsecase basePostUsecase;

  PostsService({required this.baseGetUsecase, required this.basePostUsecase});

  @override
  Future<Either<Failure, List<PostModel>>> fetchPosts() async {
    try {
      final fetchPostsEither = await baseGetUsecase(
          GetRequestParam(endPoint: AppEndpoint.fetchPosts));
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
