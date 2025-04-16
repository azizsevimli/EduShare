import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavoriteMaterial({required String materialId}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('users').doc(uid).update({
      'favoriteMaterials': FieldValue.arrayUnion([materialId])
    });
  }

  Future<void> removeFavoriteMaterial({required String materialId}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _firestore.collection('users').doc(uid).update({
      'favoriteMaterials': FieldValue.arrayRemove([materialId])
    });
  }

  Future<void> clearFavorites() async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      'favoriteMaterials': [],
    });
  }

  Future<List<String>> getFavoriteMaterials() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot = await _firestore
        .collection('users')
        .doc(uid)
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

  Future<void> removeFromAllFavorites({required String id}) async {
    final usersSnapshot = await _firestore.collection('users').get();

    for (final userDoc in usersSnapshot.docs) {
      await userDoc.reference.update({
        'favoriteMaterials': FieldValue.arrayRemove([id])
      });
    }
  }
}
