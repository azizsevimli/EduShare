import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/user_service.dart';
import '../../core/constants/constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserServices us = UserServices();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      us.checkUser(
        onUserFound: () => context.go('/home'),
        onUserNotFound: () => context.go('/login'),
      );
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.orange,
        body: Center(
          child: Text(
            appName,
            style: AppTextStyles.h1.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
