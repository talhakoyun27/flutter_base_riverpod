import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/controller/base_controller.dart';
import 'package:flutter_base_riverpod/model/posts_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_post_service.dart';
import 'package:flutter_base_riverpod/usecase/posts_usecase.dart';

class PostsController extends BaseController {
  final PostsUseCase postsUseCase;
  final IPostsService postsService;

  PostsController({required this.postsUseCase, required this.postsService});

  UIState<List<PostModel>> postsState = UIState.idle();
  Future<void> fetchPosts() async {
    postsState = UIState.loading();
    final fetchPostsEither = await postsUseCase(NoParams());
    fetchPostsEither.fold((failure) {
      postsState = UIState.error(failure);
    }, (data) {
      postsState = UIState.success(data);
    });
    refreshView();

  }
}
