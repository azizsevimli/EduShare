import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_services.dart';
import '../../core/utils/show_snackbar.dart';
import '../../core/constants/constants.dart';
import '../../core/widgets/custom_text_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  Future<void> loginBtn() async {
    await authService.signInUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        onError: (String message) => ShowSnackBar.showSnackBar(context, message),
        onSuccess: loginOnSuccess,
    );
  }

  Future<void> resetPasswordBtn() async {
    await authService.resetPassword(
      email: emailController.text.trim(),
      onError: (String message) => ShowSnackBar.showSnackBar(context, message),
      onSuccess: resetOnSuccess,
    );
  }

  void loginOnSuccess(UserCredential userCredential) {
    ShowSnackBar.showSnackBar(context, 'Giriş başarılı: ${userCredential.user?.email}');
    context.go('/home');
  }

  void resetOnSuccess() {
    ShowSnackBar.showSnackBar(context, 'Şifre sıfırlama maili gönderildi!');
    emailController.clear();
    passwordController.clear();
  }

  void passwordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void goSignUpPage() {
    context.go('/signup');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Text(
                  'EduShare',
                  style: AppTextStyles.h1.copyWith(color: AppColors.tiffany),
                ),
              ),
              EmailField(controller: emailController),
              const SizedBox(height: 15.0),
              PasswordField(controller: passwordController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: resetPasswordBtn,
                    child: const Text('Şifremi Unuttum'),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              SizedBox(
                width: width * 0.4,
                child: ElevatedButton(
                  onPressed: loginBtn,
                  child: const Text('Giriş Yap'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Hesabınız yok mu?", style: AppTextStyles.body2),
                  TextButton(
                    onPressed: goSignUpPage,
                    child: const Text("Kayıt olun"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}