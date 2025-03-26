import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavoriteMaterial({required String materialId}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'favoriteMaterials': FieldValue.arrayUnion([materialId])
    });
  }

  Future<void> removeFavoriteMaterial({required String materialId}) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      'favoriteMaterials': FieldValue.arrayRemove([materialId])
    });
  }

  Future<List<String>> getFavoriteMaterials() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .get();

    final favorites = docSnapshot.data()?['favoriteMaterials'];

    if (favorites is List<dynamic>) {
      return favorites.cast<String>();
    } else {
      return [];
    }
  }

  Future<bool> isFavorite({required String materialId}) async {
    final favorites = await getFavoriteMaterials();
    return favorites.contains(materialId);
  }

  Future<void> removeFromAllFavorites(String id) async {
    final usersSnapshot = await _firestore.collection('users').get();

    for (final userDoc in usersSnapshot.docs) {
      final userRef = userDoc.reference;

      await userRef.update({
        'favoriteMaterials': FieldValue.arrayRemove([id])
      });
    }
  }
}
