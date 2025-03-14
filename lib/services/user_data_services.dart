import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edushare/models/user_model.dart';

class UserData{
  Future<UserModel?> getUserData(String uid) async{
    FirebaseFirestore ffs = FirebaseFirestore.instance;
    UserModel? user;

    DocumentSnapshot documentSnapshot = await ffs.collection('users').doc(uid).get();

    if (documentSnapshot.exists) {
      user = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    }

    return user;
  }
}