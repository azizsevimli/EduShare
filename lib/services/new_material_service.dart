import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './upload_image_service.dart';
import '../models/material_model.dart';

Future<void> uploadMaterial({
  required String id,
  required String owner,
  required String title,
  required String description,
  required String cost,
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
      owner: owner,
      title: title,
      price: cost,
      description: description,
      category: category,
      subcategory: subcategory,
      subject: subject,
      imageUrls: imageUrls,
      isSold: isSold!,
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

    debugPrint("Ürün Firestore'a kaydedildi.");
  } catch (e) {
    debugPrint("Ürün kaydedilirken hata oluştu: $e");
  }
}
