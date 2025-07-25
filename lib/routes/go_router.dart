import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internship_task/Screens/Home.dart';
import 'package:internship_task/Screens/Login.dart';
import 'package:internship_task/Screens/SignUp.dart';
import 'package:internship_task/Screens/Wellcome.dart';
import 'package:internship_task/routes/error_route.dart';
import 'package:internship_task/routes/route_transition.dart';

class MyAppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: "Wellcome",
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: Wellcome());
        },
      ),
      GoRoute(
        name: "Login",
        path: '/Login',
        pageBuilder: (context, state) {
          return RightToLeft(
            key: state.pageKey,
            child: Login(), // Replace with your widget
          );
        },
      ),

      GoRoute(
        name: "SignUp",
        path: '/SignUp',
        pageBuilder: (context, state) {
          return RightToLeft(
            key: state.pageKey,
            child: SignUp(), // Replace with your widget
          );
        },
      ),

      GoRoute(
        name: "HomeScreen",
        path: '/HomeScreen',
        pageBuilder: (context, state) {
          return RightToLeft(
            key: state.pageKey,
            child: HomeScreen(), // Replace with your widget
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(child: ErrorPage());
    },
  );
}
