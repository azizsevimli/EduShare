import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/models/user_model.dart';
import 'package:flutter/cupertino.dart';

Future<void> registerUser({
  required String name,
  required String surname,
  required String mail,
  required String phone,
  required String password,
  required String degree,
  required String grade,
  required String university,
  required String department,
  required Function(String message) onError,
  required Function(UserCredential userCredential) onSuccess,
}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mail, password: password);
    String userId = userCredential.user!.uid;

    UserModel user = UserModel(
      uuid: userId,
      name: name,
      surname: surname,
      mail: mail,
      phone: phone,
      degree: degree,
      grade: grade,
      university: university,
      department: department,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(user.toMap());

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
