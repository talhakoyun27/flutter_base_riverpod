import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/constants/app_router.dart';
import 'package:flutter_base_riverpod/_library/error/failure/failure.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/locale_key_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/arg/locale_key_with_value_param.dart';
import 'package:flutter_base_riverpod/_library/helpers/locale_manager/locale_manager.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/_library/widgets/loader.dart';
import 'package:flutter_base_riverpod/controller/base_controller.dart';
import 'package:flutter_base_riverpod/model/login_arg_model.dart';
import 'package:flutter_base_riverpod/model/user.dart';
import 'package:flutter_base_riverpod/service/auth_service.dart';

class AuthController extends BaseController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late LogInArgument logInArgument;
  @override
  init() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  disp() {
    emailController.dispose();
    passwordController.dispose();
  }

  setLoginArgument({LogInArgument? argument, bool isSplash = false}) {
    logInArgument = argument ??
        LogInArgument(
          email: (emailController.text).trim(),
          password: (passwordController.text).trim(),
        );
    login(argument: argument);
  }

  UIState<User> currentUser = UIState.idle();
  login({LogInArgument? argument}) async {
    Loader.show(GlobalKeyManager.scaffoldMessengerKey.currentState!.context);
    try {
      AuthService().login(logInArgument).then((value) {
        Loader.hide();
        value.fold(
          (failure) => failure.showSnackBar(),
          (data) {
            currentUser = UIState.success(data);
            saveLocale(argument: argument);
            router.go("/home");
            clearUserArgumentController();
          },
        );
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  saveLocale({LogInArgument? argument}) async {
    await locator<LocaleManager>().saveDataFromKey(LocaleKeyWithValueParam(
      LocalKeys.loginInfo,
      data: LogInArgument(
        email: argument?.email ?? emailController.text.trim(),
        password: argument?.password ?? passwordController.text.trim(),
      ).toJson(),
    ));
  }

  getUserInfo() async {
    try {
      final userEither = await locator<LocaleManager>()
          .getDataFromKey(LocaleKeyParam(LocalKeys.loginInfo));
      userEither.fold((failure) => router.go("/login"), (data) {
        setLoginArgument(argument: LogInArgument.fromMap(json.decode(data)));
      });
    } catch (e) {
      return Left(ServiceFailure(errorText: e.toString()));
    }
  }

  void clearUserArgumentController() {
    emailController.clear();
    passwordController.clear();
  }
}
