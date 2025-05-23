import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_services.dart';
import '../../core/constants/constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.checkUser(
        onAdminFound: () => context.go('/admin/home'),
        onUserFound: () => context.go('/home'),
        onUserNotFound: () => context.go('/login'),
      );
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.tiffany,
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
