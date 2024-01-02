import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/controller/authentication.dart';
import 'package:flutter_base_riverpod/_library/helpers/injection.dart';
import 'package:flutter_base_riverpod/_library/widgets/app_scaffold.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final auth = serviceLocator<Authentication>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: auth.emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: auth.passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  auth.setLoginArgumentAndLogin();
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
