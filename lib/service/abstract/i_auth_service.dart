import 'package:flutter_base_riverpod/model/login_arg_model.dart';

abstract class IAuthService {
  login(LogInArgument argument);
  register(String mail, String password);
}
