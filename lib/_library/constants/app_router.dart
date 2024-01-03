import 'package:flutter/material.dart';
import 'package:flutter_base_riverpod/view/authentication/login/login_view.dart';
import 'package:flutter_base_riverpod/view/home/home_view.dart';
import 'package:flutter_base_riverpod/view/settings/settings_view.dart';
import 'package:flutter_base_riverpod/view/splash/splash_view.dart';

import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
// final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      name: "splash",
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
      routes: <RouteBase>[
        GoRoute(
          name: "login",
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        GoRoute(
          name: "home",
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeView();
          },
        ),
        GoRoute(
          name: "settings",
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsView();
          },
        ),
      ],
    ),
  ],
);
