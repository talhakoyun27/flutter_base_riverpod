import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/_library/helpers/usefull_functions.dart';
import 'package:flutter_base_riverpod/view/authentication/login/login_view.dart';
import 'package:flutter_base_riverpod/view/home/home_view.dart';
import 'package:flutter_base_riverpod/view/splash/splash_view.dart';
import 'package:flutter_base_riverpod/view/settings/settings_view.dart';
import 'package:go_router/go_router.dart';

@immutable
final class AppRouter {
  static final AppRouter _instance = AppRouter._init();
  AppRouter._init();

  factory AppRouter() {
    return _instance;
  }

  final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: GlobalContextKey.instance.globalKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginView();
            },
          ),
          GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomeView();
            },
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsView();
            },
          ),
        ],
      ),
    ],
  );
}
