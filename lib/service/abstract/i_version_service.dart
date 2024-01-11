import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/argument/get_request_param.dart';
import 'package:flutter_base_riverpod/model/version_model.dart';

abstract class IVersionService {
  Future<Either<Failure, VersionModel>> fetchVersion(
      {required GetRequestParam params});
}
