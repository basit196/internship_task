import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship_task/Screens/Cart.dart';
import 'package:internship_task/Screens/Home.dart';
import 'package:internship_task/Screens/Login.dart';
import 'package:internship_task/Screens/SignUp.dart';
import 'package:internship_task/Screens/Wellcome.dart';
import 'package:internship_task/routes/error_route.dart';
import 'package:internship_task/routes/route_transition.dart';

class MyAppRouter {
  static GoRouter router(User? user) {
    return GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isAtLoginOrWelcome =
            state.matchedLocation == '/' ||
            state.matchedLocation == '/Login' ||
            state.matchedLocation == '/SignUp';

        if (user == null && !isAtLoginOrWelcome) {
          return '/';
        }

        if (user != null && state.matchedLocation == '/') {
          return '/HomeScreen';
        }

        return null;
      },
      routes: [
        GoRoute(
          name: "Wellcome",
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: Wellcome()),
        ),
        GoRoute(
          name: "Login",
          path: '/Login',
          pageBuilder: (context, state) =>
              RightToLeft(key: state.pageKey, child: const Login()),
        ),
        GoRoute(
          name: "SignUp",
          path: '/SignUp',
          pageBuilder: (context, state) =>
              RightToLeft(key: state.pageKey, child: SignUp()),
        ),
        GoRoute(
          name: "HomeScreen",
          path: '/HomeScreen',
          pageBuilder: (context, state) =>
              RightToLeft(key: state.pageKey, child: const HomeScreen()),
        ),

        GoRoute(
          name: "CartScreen",
          path: '/CartScreen',
          pageBuilder: (context, state) =>
              RightToLeft(key: state.pageKey, child: const CartScreen()),
        ),
      ],
      errorPageBuilder: (context, state) =>
          const MaterialPage(child: ErrorPage()),
    );
  }
}
