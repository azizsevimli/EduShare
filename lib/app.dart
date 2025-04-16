import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './core/constants/constants.dart';
import 'core/widgets/app_bar.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  const AppLayout({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String? location = GoRouter.of(context).state.path;
    if (location!.startsWith('/home')) {
      return 0;
    } else if (location.startsWith('/search')) {
      return 1;
    } else if (location.startsWith('/my-materials')) {
      return 2;
    } else if (location.startsWith('/profile')) {
      return 3;
    } else if (location.startsWith('/material-add')) {
      return 4;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      appBar: buildAppBar(context: context, index: currentIndex),
      body: child,
      bottomNavigationBar: _buildBottomAppBar(context: context, index: currentIndex),
      floatingActionButton: _buildFloatingActionButton(context, currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomAppBar _buildBottomAppBar({required BuildContext context, required int index}) {
    return BottomAppBar(
      notchMargin: 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildBottomNavigationIcon(
            context,
            index,
            index: 0,
            selectedIcon: Icons.home,
            unselectedIcon: Icons.home_outlined,
            route: '/home',
          ),
          _buildBottomNavigationIcon(
            context,
            index,
            index: 1,
            selectedIcon: Icons.search,
            unselectedIcon: Icons.manage_search,
            route: '/search',
          ),
          if (index != 4) const SizedBox(width: 40),
          _buildBottomNavigationIcon(
            context,
            index,
            index: 2,
            selectedIcon: Icons.list_alt_outlined,
            unselectedIcon: Icons.format_list_bulleted,
            route: '/my-materials',
          ),
          _buildBottomNavigationIcon(
            context,
            index,
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
      color: currentIndex == index ? AppColors.darkPeriwinkle : AppColors.white,
      iconSize: currentIndex == index ? 28 : 24,
      onPressed: () => context.go(route),
    );
  }

  FloatingActionButton? _buildFloatingActionButton(
      BuildContext context, int currentIndex) {
    if (currentIndex == 4) {
      return null;
    }
    return FloatingActionButton(
      onPressed: () => context.go('/material-add'),
      child: const Icon(
        Icons.add_circle_outline,
        size: 24,
      ),
    );
  }
}
