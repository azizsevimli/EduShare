import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/models/product_model.dart';
import 'package:edushare/services/upload_image_service.dart';

Future<void> uploadProduct({
  required String owner,
  required String title,
  required String description,
  required String cost,
  required String department,
  required String subject,
  required List<File?> images,
}) async {
  try {
    FirebaseFirestore ffs = FirebaseFirestore.instance;

    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) {
        String? imageUrl = await uploadImageToStorage(images[i]!, "products", owner);
        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        }
      }
    }

    ProductModel product = ProductModel(
      owner: owner,
      title: title,
      price: cost,
      description: description,
      department: department,
      subject: subject,
      imageUrl: imageUrls,
    );

    await ffs.collection('products').doc('${DateTime.now().millisecondsSinceEpoch}_$owner').set(product.toMap());
    await ffs.collection('users').doc(owner).collection('products').doc('${DateTime.now().millisecondsSinceEpoch}_$owner').set(product.toMap());

    print("Ürün başarıyla Firestore'a kaydedildi!");
  } catch (e) {
    print("Ürün kaydedilirken hata oluştu: $e");
  }
}
