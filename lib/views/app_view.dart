import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/config/theme/theme.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border(
                bottom: BorderSide(
                  color: AppColor.black.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: AppBar(
              title: const Text('EduShare'),
              actions: [
                IconButton(
                    icon: const Icon(Icons.more_vert_rounded),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
        body: navigationShell,
        bottomNavigationBar: bottomNavBar(context));
  }

  NavigationBarTheme bottomNavBar(BuildContext context) {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
      child: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_add_outlined),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.sms_outlined),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
