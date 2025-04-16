import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoryServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategories() async {
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
      final List<String> subcategories = List<String>.from(data['subcategories'] ?? []);
      return subcategories;
    } else {
      return [];
    }
  }

  Future<void> addCategory() async {
    // Yeni kategori ekleme işlemleri bu alanda yapılacak.
  }

  Future<void> updateCategory() async {
    // Kategori güncelleme işlemleri burada yapılacak
  }

  Future<void> deleteCategory() async {
    // Kategori silme işlemleri buradan yapılacak
  }
}
