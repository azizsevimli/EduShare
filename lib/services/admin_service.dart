import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../core/constants/constants.dart';
import '../models/user_model.dart';

class AdminServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNewAdmin({
    required String mail,
    required String password,
    required String name,
    required String surname,
    required String phone,
    required String adminPassword,
    required Function(String message) onError,
    required Function(UserCredential userCredential) onSuccess
  }) async {
    try {
      final currentUser = _auth.currentUser;
      final currentEmail = currentUser?.email;
      debugPrint('currentEmail: $currentEmail');
      final currentPassword = adminPassword;

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      String userId = userCredential.user!.uid;

      UserModel user = UserModel(
        uid: userId,
        name: name,
        surname: surname,
        mail: mail,
        phone: phone,
        degree: '',
        grade: '',
        university: '',
        department: '',
        imageUrl: defaultProfileImageUrl,
        isAdmin: true,
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .set(user.toMap());

      if (currentEmail != null) {
        await _auth.signOut();
        await _auth.signInWithEmailAndPassword(
          email: currentEmail,
          password: currentPassword,
        );
      }

      onSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Bu e-posta adresi zaten kullanımda!';
      } else {
        errorMessage = 'Bir hata oluştu: ${e.message}';
      }
      onError(errorMessage);
    } catch (e) {
      onError('Bir hata oluştu: $e');
    }
  }

  Future<List<UserModel>> getAdminUsers() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('isAdmin', isEqualTo: true)
        .orderBy('name')
        .get();

    return querySnapshot.docs.map((doc) {
      return UserModel.fromMap(doc.data());
    }).toList();
  }

  Future<List<UserModel>> getUsers() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('isAdmin', isEqualTo: false)
        .orderBy('name')
        .get();

    return querySnapshot.docs.map((doc) {
      return UserModel.fromMap(doc.data());
    }).toList();
  }
}
