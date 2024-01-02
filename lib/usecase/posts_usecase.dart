import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/model/posts_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_post_service.dart';

class PostsUseCase implements IUsecase<List<PostModel>, NoParams> {
  final IPostsService _postsService;

  PostsUseCase(this._postsService);

  @override
  Future<Either<Failure, List<PostModel>>> call(NoParams params) async {
    return await _postsService.fetchPosts();
  }
}
