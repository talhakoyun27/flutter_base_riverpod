import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/enum/app_endpoint.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/controller/base_controller.dart';
import 'package:flutter_base_riverpod/model/posts_model.dart';
import 'package:flutter_base_riverpod/service/posts_service.dart';

class PostsController extends BaseController {
  PostsController();

  UIState<List<PostModel>> postsState = UIState.idle();
  Future<void> fetchPosts({Map<String, String>? queryParam}) async {
    postsState = UIState.loading();
    final fetchPostsEither = await PostsService().fetchPosts(GetRequestParam(
        endPoint: AppEndpoint.fetchPosts, queryParameters: queryParam));
    fetchPostsEither.fold((failure) {
      postsState = UIState.error(failure);
    }, (data) {
      postsState = UIState.success(data);
    });
    refreshView();
  }
}
