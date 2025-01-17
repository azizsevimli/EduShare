import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/core/utils/utils.dart';
import 'package:edushare/core/widgets/input_widgets.dart';
import 'package:edushare/core/constants/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpBtn() {
    if (nameController.text.isEmpty ||
        surnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.length != 10 ||
        passwordController.text.isEmpty) {
      Utils.showSnackBar(context, 'Lütfen tüm alanları doldurun!');
    } else {
      context.push(
        '/signup/profile-info',
        extra: {
          'name': nameController.text.trim(),
          'surname': surnameController.text.trim(),
          'mail': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );
    }
  }

  void goLogInPage() {
    context.go('/login');
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: Text(
                  'EduShare',
                  style: AppTextStyles.h1.copyWith(color: AppColors.orange),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OnlyTextField(
                      controller: nameController,
                      labelText: 'Ad',
                      hintText: 'Adınızı girin',
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Expanded(
                    flex: 1,
                    child: OnlyTextField(
                      controller: surnameController,
                      labelText: 'Soyad',
                      hintText: 'Soyadınızı girin',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              EmailField(controller: emailController),
              SizedBox(height: 15.0),
              PhoneField(controller: phoneController),
              SizedBox(height: 15.0),
              PasswordField(controller: passwordController),
              SizedBox(height: 15.0),
              SizedBox(
                width: width * 0.4,
                child: ElevatedButton(
                  onPressed: signUpBtn,
                  child: Text('İleri'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Zaten hesabınız var mı?", style: AppTextStyles.body2),
                  TextButton(
                    onPressed: goLogInPage,
                    child: Text("Giriş yapın"),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
