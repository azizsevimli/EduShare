import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_model.dart';
import '../../services/upload_image_service.dart';

Future<void> uploadProduct({
  required String id,
  required String owner,
  required String title,
  required String description,
  required String cost,
  required String department,
  required String subject,
  required List<File?> images,
  required bool isSold,
}) async {
  try {
    FirebaseFirestore ffs = FirebaseFirestore.instance;
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) {
        String? imageUrl = await uploadImageToStorage(
          image: images[i]!,
          document: "products",
          owner: owner,
          id: id,
          index: i,
        );
        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        }
      }
    }

    ProductModel product = ProductModel(
      id: id,
      owner: owner,
      title: title,
      price: cost,
      description: description,
      department: department,
      subject: subject,
      imageUrls: imageUrls,
      isSold: isSold,
    );

    await ffs
        .collection('products')
        .doc('${owner}_$id')
        .set(product.toMap());
    await ffs
        .collection('users')
        .doc(owner)
        .collection('products')
        .doc('${id}_$owner')
        .set(product.toMap());
    debugPrint("Ürün Firestore'a kaydedildi.");
  } catch (e) {
    debugPrint("Ürün kaydedilirken hata oluştu: $e");
  }
}
