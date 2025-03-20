import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUser(context);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.orange,
        body: Center(
          child: Text('EduShare', style: AppTextStyles.h1.copyWith(color: AppColors.white)),
        ),
      ),
    );
  }

  void _checkUser(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }
}
