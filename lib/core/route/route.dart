import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app.dart';
import '../../pages/Splash/splash_page.dart';
import '../../pages/Login/login_page.dart';
import '../../pages/Signup/signup_page.dart';
import '../../pages/SignUp/signup_info_page.dart';
import '../../pages/Home/home_page.dart';
import '../../pages/Search/search_page.dart';
import '../../pages/ProductAdd/product_add_page.dart';
import '../../pages/Messages/messages_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Profile/profile_edit_page.dart';
import '../../pages/ProductDetail/product_detail_page.dart';
import '../../pages/UserDetail/user_detail_page.dart';

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
          return const SignUpPage();
        },
        routes: [
          GoRoute(
            path: 'profile-info',
            builder: (BuildContext context, GoRouterState state) {
              final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
              return SignUpInfoPage(data: data);
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchPage(),
            ),
          ),
          GoRoute(
            path: '/product-add',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProductAddPage(),
            ),
          ),
          GoRoute(
            path: '/messages',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MessagesPage(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
              child: ProfilePage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return ProfileEditPage(data: data);
        },
      ),
      GoRoute(
        path: '/user-detail/:id',
        builder: (BuildContext context, GoRouterState state) {
          final userId = state.pathParameters['id']!;
          return UserDetailPage(userId: userId);
        },
      ),
      GoRoute(
        path: '/product-detail/:id',
        builder: (BuildContext context, GoRouterState state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailPage(productId: productId);
        },
      ),
    ],
  );
}
