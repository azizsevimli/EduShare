import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signInUser({
    required String email,
    required String password,
    required Function(String message) onError,
    required Function(UserCredential userCredential) onSuccess,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      onError('Lütfen tüm alanları doldurun!');
      return;
    }

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'Kullanıcı bulunamadı!';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Yanlış şifre!';
      } else {
        errorMessage = 'Bir hata oluştu: ${e.message}';
      }
      onError(errorMessage);
    }
  }

  Future<void> resetPassword({
    required String email,
    required Function(String message) onError,
    required Function() onSuccess,
  }) async {
    if (email.isEmpty) {
      onError('Lütfen e-posta adresinizi girin!');
      return;
    }

    try {
      await auth.sendPasswordResetEmail(email: email);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError('Bir hata oluştu: ${e.message}');
    }
  }
}
