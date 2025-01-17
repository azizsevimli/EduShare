import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edushare/core/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> logoutBtn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      context.go('/login');
    } catch (e) {
      Utils.showSnackBar(context, 'Çıkış yapılırken hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Page'),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => logoutBtn(context),
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
