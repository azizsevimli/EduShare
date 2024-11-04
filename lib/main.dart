import 'package:edushare/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:edushare/config/route/router.dart';

void main() {
  runApp(const EduShare());
}

class EduShare extends StatelessWidget {
  const EduShare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.themeData,
      title: 'EduShare',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
