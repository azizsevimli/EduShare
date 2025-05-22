import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './favorite_service.dart';
import './delete_image_service.dart';
import './upload_image_service.dart';
import '../models/material_model.dart';

class MaterialServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FavoriteService _favoriteService = FavoriteService();
  final DeleteImageService _deleteImageService = DeleteImageService();

  Future<MaterialModel?> getMaterialById({required String id}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('materials')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return MaterialModel.fromMap(querySnapshot.docs.first.data());
    } else {
      return null;
    }
  }

  Future<List<DocumentSnapshot>> fetchMaterials({
    required int limit,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = FirebaseFirestore.instance
        .collection('materials')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs;
  }

  Future<void> uploadMaterial({
    required String id,
    required String owner,
    required String title,
    required String description,
    required String price,
    required String category,
    required String subcategory,
    required String subject,
    required List<File?> images,
    bool? isSold = false,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        if (images[i] != null) {
          String? imageUrl = await uploadImageToStorage(
            image: images[i]!,
            document: "materials",
            owner: owner,
            id: id,
            index: i,
          );
          if (imageUrl != null) {
            imageUrls.add(imageUrl);
          }
        }
      }

      MaterialModel material = MaterialModel(
        id: id,
        title: title,
        description: description,
        price: price,
        category: category,
        subcategory: subcategory,
        subject: subject,
        imageUrls: imageUrls,
        owner: owner,
        isSold: isSold ?? false,
        createdAt: DateTime.now(),
      );

      await firestore
          .collection('materials')
          .doc('${owner}_$id')
          .set(material.toMap());

      await firestore
          .collection('users')
          .doc(owner)
          .collection('materials')
          .doc('${id}_$owner')
          .set(material.toMap());

      debugPrint("Materyal Firestore'a kaydedildi.");
    } catch (e) {
      debugPrint("Materyal kaydedilirken hata oluştu: $e");
    }
  }

  Future<void> updateMaterial({required MaterialModel material}) async {
    final reference1 = _firestore
        .collection('materials')
        .doc('${material.owner}_${material.id}');
    final reference2 = _firestore
        .collection('users')
        .doc(material.owner)
        .collection('materials')
        .doc('${material.id}_${material.owner}');

    await reference1.update(material.toMap());
    await reference2.update(material.toMap());
  }

  Future<void> deleteMaterial({
    required String id,
    required int imageCount,
  }) async {
    final String uid = _auth.currentUser!.uid;
    final String path = 'materials/${uid}_${id}_';

    await _firestore.collection('materials').doc('${uid}_$id').delete();
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('materials')
        .doc('${id}_$uid')
        .delete();
    for (int i = 0; i < imageCount; i++) {
      _deleteImageService.deleteImage(path: '$path$i.jpg');
    }
    await _favoriteService.removeFromAllFavorites(id: id);
  }

  Future<void> updateIsSold({required MaterialModel material}) async {
    final reference1 = _firestore
        .collection('materials')
        .doc('${material.owner}_${material.id}');
    final reference2 = _firestore
        .collection('users')
        .doc(material.owner)
        .collection('materials')
        .doc('${material.id}_${material.owner}');

    await reference1.update({'isSold': true});
    await reference2.update({'isSold': true});
  }

  Future<List<MaterialModel>> searchMaterial({required String query}) async {
    if (query.trim().isEmpty) return [];

    final snapshot = await _firestore
        .collection('materials')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    return snapshot.docs
        .map((doc) => MaterialModel.fromMap(doc.data()))
        .toList();
  }

  Future<List<MaterialModel>> fetchSimilarMaterials({
    required String subcategory,
    required String id,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('materials')
        .where('subcategory', isEqualTo: subcategory)
        .where('id', isNotEqualTo: id)
        .where('isSold', isEqualTo: false)
        .limit(10)
        .get();

    return querySnapshot.docs
        .map((doc) => MaterialModel.fromMap(doc.data()))
        .toList();
  }
}
