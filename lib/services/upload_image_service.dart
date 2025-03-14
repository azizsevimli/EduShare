import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImageToStorage(File image, String document, String owner) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName = '$document/${DateTime.now().millisecondsSinceEpoch}_$owner.jpg';
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print("Resim yüklenirken hata oluştu: $e");
    return null;
  }
}
