import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edushare/core/utils/show_snackbar.dart';
import 'package:edushare/core/utils/validation.dart';
import 'package:edushare/core/widgets/input_widgets.dart';
import 'package:edushare/core/constants/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpBtn() {
    if (nameController.text.isEmpty || nameController.text.length < 3) {
      ShowSnackBar.showSnackBar(context, 'Lütfen geçerli bir ad girin (Min. 3 karakter)');
    } else if(surnameController.text.isEmpty || surnameController.text.length < 3){
      ShowSnackBar.showSnackBar(context, 'Lütfen geçerli bir soyad girin (Min. 3 karakter)');
    } else if (emailController.text.isEmpty || !Validation.isValidEmail(emailController.text.trim())) {
      ShowSnackBar.showSnackBar(context, 'Lütfen geçerli bir mail adresi girin');
    } else if (phoneController.text.isEmpty || !Validation.isValidTurkishPhoneNumber(phoneController.text.trim())) {
      ShowSnackBar.showSnackBar(context, 'Lütfen geçerli bir telefon numarası girin');
    } else if (passwordController.text.isEmpty || !Validation.isValidPassword(passwordController.text.trim())) {
      ShowSnackBar.showSnackBar(context, 'Lütfen geçerli bir şifre girin');
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
            child: SingleChildScrollView(
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
                        child: TextFieldWithLabel(
                          controller: nameController,
                          labelText: 'Ad',
                          hintText: 'Adınızı girin',
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        flex: 1,
                        child: TextFieldWithLabel(
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
                  SizedBox(height: 5.0),
                  Text(
                    'Şifreniz büyük harf, küçük harf rakam ve özel karakter içermeli (Min. 8 karakter)',
                    style: AppTextStyles.caption.copyWith(color: AppColors.brown),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: width * 0.4,
                    child: ElevatedButton(
                      onPressed: signUpBtn,
                      child: Text('İleri'),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
          ),
        ),
      ),
    );
  }
}
