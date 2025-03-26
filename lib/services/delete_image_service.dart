import 'package:firebase_storage/firebase_storage.dart';

class DeleteImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> deleteImage({required String path}) async {
    await _storage.ref().child(path).delete();
  }
}