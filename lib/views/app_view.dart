import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/config/theme.dart';

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
                  onPressed: () {},
                ),
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
        elevation: 1,
        indicatorColor: AppColor.orange,
        backgroundColor: AppColor.orange,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: AppColor.white),
        ),
      ),
      child: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: 25,
            ),
            label: 'Home',
            selectedIcon: Icon(
              Icons.home_rounded,
              size: 30,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search_rounded,
              size: 25,
            ),
            label: 'Search',
            selectedIcon: Icon(
              Icons.search_rounded,
              size: 30,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_box_outlined,
              size: 25,
            ),
            label: 'Add',
            selectedIcon: Icon(
              Icons.add_box_rounded,
              size: 30,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.sms_outlined,
              size: 25,
            ),
            label: 'Messages',
            selectedIcon: Icon(
              Icons.sms_rounded,
              size: 30,
            ),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 25,
            ),
            label: 'Profile',
            selectedIcon: Icon(
              Icons.account_circle_rounded,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
