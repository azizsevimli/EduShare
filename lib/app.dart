import 'package:edushare/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String? location = GoRouter.of(context).state.path;
    if (location!.startsWith('/home')) {
      return 0;
    } else if (location.startsWith('/search')) {
      return 1;
    } else if (location.startsWith('/messages')) {
      return 2;
    } else if (location.startsWith('/profile')) {
      return 3;
    } else if (location.startsWith('/product-add')) {
      return 4;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _calculateSelectedIndex(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(currentIndex, context),
        body: child,
        bottomNavigationBar: _buildBottomAppBar(currentIndex, context),
        floatingActionButton: _buildFloatingActionButton(context, currentIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  AppBar _buildAppBar(int currentIndex, BuildContext context) {
    return AppBar(
      title: const Text('EduShare'),
      actions: [
        currentIndex == 3
            ? IconButton(
          icon: Icon(Icons.settings),
          color: AppColors.white,
          onPressed: () => context.go('/settings'),
        )
            : const SizedBox(),
      ],
    );
  }

  BottomAppBar _buildBottomAppBar(int currentIndex, BuildContext context) {
    return BottomAppBar(
      notchMargin: 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBottomNavigationIcon(
            context,
            currentIndex,
            index: 0,
            selectedIcon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            route: '/home',
          ),
          _buildBottomNavigationIcon(
            context,
            currentIndex,
            index: 1,
            selectedIcon: Icons.search,
            unselectedIcon: Icons.manage_search,
            route: '/search',
          ),
          if (currentIndex != 4)
            const SizedBox(width: 40),
          _buildBottomNavigationIcon(
            context,
            currentIndex,
            index: 2,
            selectedIcon: Icons.mail,
            unselectedIcon: Icons.mail_outline,
            route: '/messages',
          ),
          _buildBottomNavigationIcon(
            context,
            currentIndex,
            index: 3,
            selectedIcon: Icons.person,
            unselectedIcon: Icons.person_outline,
            route: '/profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationIcon(
      BuildContext context,
      int currentIndex, {
        required int index,
        required IconData selectedIcon,
        required IconData unselectedIcon,
        required String route,
      }) {
    return IconButton(
      icon: Icon(currentIndex == index ? selectedIcon : unselectedIcon),
      color: currentIndex == index ? AppColors.orange : AppColors.brown,
      iconSize: currentIndex == index ? 28 : 24,
      onPressed: () => context.go(route),
    );
  }

  FloatingActionButton? _buildFloatingActionButton(BuildContext context, int currentIndex) {
    if (currentIndex == 4) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () => context.go('/product-add'),
      child: Icon(
        Icons.add_circle_outline,
        size: 24,
      ),
    );
  }
}
