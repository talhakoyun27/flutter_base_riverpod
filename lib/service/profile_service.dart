import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_get_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/base_post_usecase.dart';
import 'package:flutter_base_riverpod/model/profile_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_profile_service.dart';

class ProfileService implements IProfileService {
  final BasePostUsecase _basePostUsecase;

  ProfileService(this._basePostUsecase);

  @override
  Future<Either<Failure, Profile>> fetchProfile({required int? id}) {
    throw UnimplementedError();
  }
}
