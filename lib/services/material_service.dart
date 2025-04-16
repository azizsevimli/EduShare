import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './favorite_service.dart';
import './delete_image_service.dart';
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

  Future<List<DocumentSnapshot>> fetchMaterialDocuments({
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

  Future<List<MaterialModel>> fetchSimilarMaterials({
    required String subcategory,
    required String id,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('materials')
        .where('subcategory', isEqualTo: subcategory)
        .where('id', isNotEqualTo: id)
        .where('isSold', isEqualTo: false)
        .limit(10).get();


    return querySnapshot.docs
        .map((doc) => MaterialModel.fromMap(doc.data()))
        .toList();
  }
}
