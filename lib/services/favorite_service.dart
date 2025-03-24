import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Favorilere ürün ekler
  Future<void> addFavoriteProduct(String productId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userDoc = _firestore.collection('users').doc(userId);

    await userDoc.update({
      'favoriteMaterials': FieldValue.arrayUnion([productId])
    });
  }

  /// Favorilerden ürün çıkarır
  Future<void> removeFavoriteProduct(String productId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userDoc = _firestore.collection('users').doc(userId);

    await userDoc.update({
      'favoriteMaterials': FieldValue.arrayRemove([productId])
    });
  }

  /// Kullanıcının favori ürünlerini getirir
  Future<List<String>> getFavoriteProducts() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    final docSnapshot = await _firestore.collection('users').doc(userId).get();
    final favorites = docSnapshot.data()?['favoriteMaterials'];

    if (favorites is List<dynamic>) {
      return favorites.cast<String>();
    } else {
      return [];
    }
  }

  /// Ürün favori mi kontrolü
  Future<bool> isFavorite(String productId) async {
    final favorites = await getFavoriteProducts();
    return favorites.contains(productId);
  }
}
