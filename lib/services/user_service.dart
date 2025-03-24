import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class UserServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        imageUrl:'https://firebasestorage.googleapis.com/v0/b/edushare-cfca8.firebasestorage.app/o/users%2Fdefault_image.jpg?alt=media&token=6590c09a-04b4-4bc2-a205-e7e5b6b0873a',
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

  Future<void> logoutUser({required Function onSuccess, required Function(String message) onError,}) async {
    try{
      await FirebaseAuth.instance.signOut();
      onSuccess();
    }catch(e){
      onError('$e');
    }
  }

  Future<UserModel?> getUserData({String? uid}) async {
    UserModel? user;

    uid ??= _auth.currentUser?.uid;
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      user = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }

    return user;
  }

  Future<List<ProductModel>> getUserProducts({String? uid}) async {
    List<ProductModel> products = [];

    uid ??= _auth.currentUser?.uid;
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('products')
        .get();

    for (QueryDocumentSnapshot<Object?> doc in snapshot.docs) {
      products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return products;
  }

  Future<List<ProductModel>> getFavoriteProducts() async {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(uid).get();

    final favorites = snapshot.data()?['favoriteMaterials'];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('products')
        .where('id', whereIn: favorites)
        .get();

    final List<ProductModel> products = querySnapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();

    return products;
  }

  Future<void> updateUser({required Map<String, dynamic> updatedData}) async {
    final String? uid = _auth.currentUser?.uid;
    if (uid == null) return;
    try {
      await _firestore.collection('users').doc(uid).update(updatedData);
      debugPrint("Veriler başarıyla güncellendi");
    } on FirebaseException catch (e) {
      debugPrint("Firebase hatası: ${e.message}");
      rethrow;
    } catch (e) {
      debugPrint("Bilinmeyen bir hata oluştu: $e");
      rethrow;
    }
  }
}
