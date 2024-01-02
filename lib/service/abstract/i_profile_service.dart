import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/model/profile_model.dart';

abstract class IProfileService {
  Future<Either<Failure, Profile>> fetchProfile({required int? id});
}
