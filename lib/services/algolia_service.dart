import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/material_model.dart';

class AlgoliaService {
  static final Algolia _algolia = const Algolia.init(
    applicationId: 'I91V7AU7T5',
    apiKey: '7c0ed5c625665f893c5aa81e3b56c8e4',
  );

  static Algolia get instance => _algolia;

  Future<List<MaterialModel>> searchMaterials({required String query}) async {
    final AlgoliaQuerySnapshot snapshot = await AlgoliaService.instance
        .index('materials_index')
        .query(query)
        .getObjects();

    List<String> objectIDs = snapshot.hits.map((e) => e.objectID).toList();

    List<MaterialModel> materials = [];

    for (String id in objectIDs) {
      try {
        final doc = await FirebaseFirestore.instance.collection('materials').doc(id).get();

        if (doc.exists) {
          materials.add(MaterialModel.fromMap(doc.data()!));
        }
      } catch (e) {
        print("Firestore'dan veri çekilirken hata: $e");
      }
    }

    return materials;
  }
}