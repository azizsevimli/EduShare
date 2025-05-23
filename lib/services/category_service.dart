import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<CategoryModel?> getCategoryById({required String id}) async {
    CategoryModel? category;
    DocumentSnapshot snapshot =
        await _firestore.collection('categories').doc(id).get();

    if (snapshot.exists) {
      category = CategoryModel.fromMap(
        map: snapshot.data() as Map<String, dynamic>,
      );
    }

    return category;
  }

  Future<List<CategoryModel>> getCategories() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('categories').get();

    return querySnapshot.docs
        .map(
          (doc) => CategoryModel.fromMap(
            map: doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  Future<List<String>> fetchSubcategories({required String category}) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('categories')
        .where('name', isEqualTo: category)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data() as Map<String, dynamic>;
      final List<String> subcategories =
          List<String>.from(data['subcategories'] ?? []);
      return subcategories;
    } else {
      return [];
    }
  }

  Future<void> addCategory({
    required CategoryModel category,
    required Function(String message) onError,
    required Function() onSuccess,
  }) async {
    try {
      final DocumentReference docRef =
          await _firestore.collection('categories').add(category.toMap());

      await docRef.set({
        'id': docRef.id,
      }, SetOptions(merge: true));

      onSuccess();
    } catch (e) {
      onError('Kategori eklenirken hata oluştu: $e');
    }
  }

  Future<void> updateCategory({
    required CategoryModel category,
  }) async {
    try {
      await _firestore.collection('categories').doc(category.id).update(category.toMap());
    } catch (e) {
      throw Exception('Kategori güncellenirken hata oluştu: $e');
    }
  }

  Future<void> deleteCategory({required String id, required Function(String message) onError,
    required Function() onSuccess,}) async {
    try {
      await _firestore.collection('categories').doc(id).delete();
      onSuccess();
    } catch (e) {
      onError('Kategori silinirken hata oluştu: $e');
    }
  }
}
