import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/network_manager/domain/usecase/i_usecase.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/_library/widgets/loader.dart';
import 'package:flutter_base_riverpod/controller/base_controller.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/model/user.dart';
import 'package:flutter_base_riverpod/service/abstract/i_authentication_service.dart';
import 'package:flutter_base_riverpod/usecase/get_login_argument_usecase.dart';
import 'package:flutter_base_riverpod/usecase/login_usecase.dart';
import 'package:flutter_base_riverpod/usecase/save_login_usecase.dart';

class Authentication extends BaseController {
  final LogInUsecase logInUsecase;
  final IAuthenticationService iAuthenticationService;
  final SaveLoginUsecase saveUsecase;
  final GetLogInArgumentUsecase getLogInArgumentUsecase;

  Authentication(this.iAuthenticationService,
      {required this.logInUsecase,
      required this.saveUsecase,
      required this.getLogInArgumentUsecase});

  TextEditingController? emailController;
  TextEditingController? passwordController;
  late LogInArgument logInArgument;

  @override
  void init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void disp() {
    emailController?.dispose();
    passwordController?.dispose();
  }

  UIState<User> currentUser = UIState.idle();
  void setLoginArgumentAndLogin(
      {LogInArgument? argument, bool isSplash = false}) {
    logInArgument = argument ??
        LogInArgument(
          email: (emailController?.text ?? "").trim(),
          password: (passwordController?.text ?? "").trim(),
        );
    logIn(isSplash: isSplash);
  }

  Future<void> logIn({bool isSplash = false}) async {
    if (!isSplash) {
      Loader.show(GlobalKeyManager.scaffoldMessengerKey.currentState!.context);
    }
    final loginEither = await logInUsecase(logInArgument);
    loginEither.fold(
      (failure) {
        if (isSplash) {
          AppRouter().router.go("/");
        } else {
          failure.showSnackBar();
        }
      },
      (data) {
        currentUser = UIState.success(data);
        saveUsecase(logInArgument);
        AppRouter().router.go("/home");
        clearUserArgumentController();
      },
    );
    if (!isSplash) {
      Loader.hide();
    }
  }

  Future<void> getUserInfo() async {
    final loginArgumentEither = await getLogInArgumentUsecase(NoParams());
    loginArgumentEither.fold(
      (failure) => AppRouter().router.go("/login"),
      (data) {
        setLoginArgumentAndLogin(argument: data, isSplash: true);
      },
    );
  }

  void clearUserArgumentController() {
    emailController?.clear();
    passwordController?.clear();
  }
}
