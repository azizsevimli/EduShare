import 'package:firebase_auth/firebase_auth.dart';

class GetUser{
  static String getUserUID() {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    return uid;
  }
}