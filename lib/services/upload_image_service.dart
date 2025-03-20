import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImageToStorage({
  required File image,
  required String document,
  required String owner,
  String? id,
  int? index,
}) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName =
        id != null
            ? '$document/${owner}_${id}_$index.jpg'
            : '$document/$owner.jpg';
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    debugPrint("Resim yüklenirken hata oluştu: $e");
    return null;
  }
}
