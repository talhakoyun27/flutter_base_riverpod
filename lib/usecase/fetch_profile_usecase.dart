import 'package:dartz/dartz.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/model/profile_model.dart';
import 'package:flutter_base_riverpod/service/abstract/i_profile_service.dart';

class FetchProfileUseCase implements IUsecase<Profile, int?> {
  final IProfileService _profilService;

  FetchProfileUseCase(this._profilService);
  @override
  Future<Either<Failure, Profile>> call(int? id) async {
    return await _profilService.fetchProfile(id: id);
  }
}
