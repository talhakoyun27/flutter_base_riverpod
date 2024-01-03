import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/locators.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';
import 'package:flutter_base_riverpod/controller/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    locator<AuthController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: locator<AuthController>().emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: locator<AuthController>().passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                locator<AuthController>().setLoginArgument();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
