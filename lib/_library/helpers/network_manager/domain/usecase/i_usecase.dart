import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';

abstract class IUsecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
