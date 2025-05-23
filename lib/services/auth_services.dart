import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
    required Function(String message) onError,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      onError('Lütfen tüm alanları doldurun!');
      return;
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;

      final userDoc = await _firestore.collection('users').doc(uid).get();
      final isAdmin = userDoc.data()?['isAdmin'] ?? false;

      if (context.mounted) {
        if (isAdmin) {
          context.go('/admin/home');
        } else {
          context.go('/home');
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Kullanıcı bulunamadı!';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Yanlış şifre!';
      } else {
        errorMessage = 'Bir hata oluştu: ${e.message}';
      }
      onError(errorMessage);
    }
  }

  void checkUser({
    required VoidCallback onAdminFound,
    required VoidCallback onUserFound,
    required VoidCallback onUserNotFound,
  }) async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        final isAdmin = doc.data()?['isAdmin'] ?? false;

        if (isAdmin) {
          onAdminFound();
        } else {
          onUserFound();
        }
      } else {
        onUserNotFound();
      }
    } else {
      onUserNotFound();
    }
  }

  Future<void> resetPassword({
    required String email,
    required Function(String message) onError,
    required Function() onSuccess,
  }) async {
    if (email.isEmpty) {
      onError('Lütfen e-posta adresinizi girin!');
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError('Bir hata oluştu: ${e.message}');
    }
  }
}
