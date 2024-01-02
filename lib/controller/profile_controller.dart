import 'package:flutter_base_riverpod/controller/base_controller.dart';
import 'package:flutter_base_riverpod/usecase/fetch_profile_usecase.dart';

class ProfileController extends BaseController {
  final FetchProfileUseCase profileUseCase;

  ProfileController({required this.profileUseCase});
}
