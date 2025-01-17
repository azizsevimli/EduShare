import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/app.dart';
import 'package:edushare/pages/Splash/splash_page.dart';
import 'package:edushare/pages/Login/login_page.dart';
import 'package:edushare/pages/Signup/signup_page.dart';
import 'package:edushare/pages/Signup/profileInfo_page.dart';
import 'package:edushare/pages/Home/home_page.dart';
import 'package:edushare/pages/Search/search_page.dart';
import 'package:edushare/pages/ProductAdd/product_add_page.dart';
import 'package:edushare/pages/Messages/messages_page.dart';
import 'package:edushare/pages/Profile/profile_page.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignupPage();
        },
        routes: [
          GoRoute(
            path: 'profile-info',
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
              return ProfileInfoPage(data: data);
            },
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (context, state) => NoTransitionPage(
              child: SearchPage(),
            ),
          ),
          GoRoute(
            path: '/product-add',
            pageBuilder: (context, state) => NoTransitionPage(
              child: ProductAddPage(),
            ),
          ),
          GoRoute(
            path: '/messages',
            pageBuilder: (context, state) => NoTransitionPage(
              child: MessagesPage(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),
    ],
  );
}
