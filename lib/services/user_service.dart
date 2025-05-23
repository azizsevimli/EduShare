import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/material_model.dart';
import '../core/constants/constants.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? getUserId() {
    return _auth.currentUser?.uid;
  }

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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
        degree: degree,
        grade: grade,
        university: university,
        department: department,
        imageUrl: defaultProfileImageUrl,
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

  Future<void> updateUser({required UserModel user}) async {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) return;
    try {
      await _firestore.collection('users').doc(uid).update(user.toMap());
      debugPrint("Veriler başarıyla güncellendi");
    } on FirebaseException catch (e) {
      debugPrint("Firebase hatası: ${e.message}");
      rethrow;
    } catch (e) {
      debugPrint("Bilinmeyen bir hata oluştu: $e");
      rethrow;
    }
  }

  Future<void> logoutUser({
    required Function onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      await _auth.signOut();
      onSuccess();
    } catch (e) {
      onError('$e');
    }
  }

  Future<UserModel?> getUserData({String? uid}) async {
    UserModel? user;

    uid ??= _auth.currentUser?.uid;
    DocumentSnapshot snapshot = await _firestore
            .collection('users')
            .doc(uid)
            .get();

    if (snapshot.exists) {
      user = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }

    return user;
  }

  Future<List<MaterialModel>> getUserMaterials({String? uid}) async {
    List<MaterialModel> materials = [];

    uid ??= _auth.currentUser?.uid;
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('materials')
        .get();

    for (QueryDocumentSnapshot<Object?> doc in snapshot.docs) {
      materials.add(MaterialModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return materials;
  }

  Future<List<MaterialModel>> getFavoriteMaterials() async {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    final favorites = snapshot.data()?['favoriteMaterials'];

    if (favorites == null || favorites.isEmpty) return [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('materials')
        .where('id', whereIn: favorites)
        .get();

    final List<MaterialModel> materials = querySnapshot.docs
        .map((doc) => MaterialModel.fromMap(doc.data()))
        .toList();

    return materials;
  }
}
