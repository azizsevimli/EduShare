import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_model.dart';
import '../../models/user_model.dart';

class UserData {
  Future<UserModel?> getUserData({required String uid}) async {
    FirebaseFirestore ffs = FirebaseFirestore.instance;
    UserModel? user;

    DocumentSnapshot snapshot = await ffs
        .collection('users')
        .doc(uid)
        .get();

    if (snapshot.exists) {
      user = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }

    return user;
  }

  Future<List<ProductModel>> getUserProducts({required String uid}) async {
    FirebaseFirestore ffs = FirebaseFirestore.instance;
    List<ProductModel> products = [];
    QuerySnapshot snapshot = await ffs
        .collection('users')
        .doc(uid)
        .collection('products')
        .get();

    for (var doc in snapshot.docs) {
      products.add(ProductModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    return products;
  }
}
