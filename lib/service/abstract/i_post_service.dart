import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/model/posts_model.dart';

abstract class IPostsService {
  Future<Either<Failure, List<PostModel>>> fetchPosts(GetRequestParam params);
  Future<Either<Failure, PostModel>> fetchPostDetail({required int id});
  // Future<Either<Failure, void>> savePost({required int id});
  // Future<void> reportDelay({required int id, required String description});
}
