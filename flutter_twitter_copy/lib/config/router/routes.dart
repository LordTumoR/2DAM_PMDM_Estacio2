import 'package:flutter/material.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';
import 'package:flutter_twitter_copy/presentations/screens/home_screen.dart';
import 'package:flutter_twitter_copy/presentations/screens/login_screen.dart';
import 'package:flutter_twitter_copy/injection.dart' as di;
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
  ],
  redirect: (context, state) async {
    final isLoggedIn = await di.sl<UserRepository>().isLoggedIn();
    return isLoggedIn.fold((_) => '/login', (loggedIn) {
      if (!loggedIn && !state.matchedLocation.contains("/login")) {
        return "/login";
      } else {
        return state.matchedLocation;
      }
    });
  },
);
