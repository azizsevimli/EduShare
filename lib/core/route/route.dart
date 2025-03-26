import 'package:edushare/pages/MaterialManagement/my_materials_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app.dart';
import '../../pages/MaterialManagement/material_edit_page.dart';
import '../../pages/Splash/splash_page.dart';
import '../../pages/Login/login_page.dart';
import '../../pages/Signup/signup_page.dart';
import '../../pages/SignUp/signup_info_page.dart';
import '../../pages/Home/home_page.dart';
import '../../pages/Search/search_page.dart';
import '../../pages/MaterialAdd/material_add_page.dart';
import '../../pages/Messages/messages_page.dart';
import '../../pages/Profile/profile_page.dart';
import '../../pages/Profile/profile_edit_page.dart';
import '../../pages/MaterialDetail/material_detail_page.dart';
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
            path: '/material-add',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MaterialAddPage(),
            ),
          ),
          GoRoute(
            path: '/my-materials',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MyMaterialsPage(),
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
        path: '/messages',
        builder: (BuildContext context, GoRouterState state) {
          return const MessagesPage();
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
        path: '/material-detail/:id',
        builder: (BuildContext context, GoRouterState state) {
          final materialId = state.pathParameters['id']!;
          return MaterialDetailPage(materialId: materialId);
        },
      ),
      GoRoute(
        path: '/my-materials/edit/:id',
        builder: (BuildContext context, GoRouterState state) {
          final materialId = state.pathParameters['id']!;
          return MaterialEditPage(materialId: materialId);
        },
      ),
    ],
  );
}
