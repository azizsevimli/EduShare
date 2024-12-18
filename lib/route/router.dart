import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/views/add/add_view.dart';
import 'package:edushare/views/app_view.dart';
import 'package:edushare/views/home/home_view.dart';
import 'package:edushare/views/message/message_view.dart';
import 'package:edushare/views/profile/pro_edit_view.dart';
import 'package:edushare/views/profile/profile_view.dart';
import 'package:edushare/views/search/search_view.dart';

final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const home = '/';
  static const search = '/search';
  static const add = '/add';
  static const messages = '/message';
  static const profile = '/profile';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppView(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.search,
              builder: (context, state) => const SearchView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.add,
              builder: (context, state) => const AddView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.messages,
              builder: (context, state) => const MessageView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => const ProfileEdit(),
    )
  ],
);
