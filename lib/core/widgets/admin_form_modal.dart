import 'package:edushare/core/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/utils/show_snackbar.dart';
import '../../services/admin_service.dart';
import 'custom_text_fields.dart';

class AdminFormModal extends StatefulWidget {
  const AdminFormModal({super.key});

  @override
  State<AdminFormModal> createState() => _AdminFormModalState();
}

class _AdminFormModalState extends State<AdminFormModal> {
  final AdminServices adminService = AdminServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController adminPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> onSave() async {
      if (nameController.text.isEmpty ||
          surnameController.text.isEmpty ||
          mailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          passwordController.text.isEmpty ||
          adminPasswordController.text.isEmpty) {
        ShowSnackBar.showSnackBar(context, 'Lütfen tüm alanları doldurun.');
      } else {
        await adminService.addNewAdmin(
          mail: mailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
          surname: surnameController.text.trim(),
          phone: phoneController.text.trim(),
          adminPassword: adminPasswordController.text.trim(),
          onError: (String message) => ShowSnackBar.showSnackBar(context, message),
          onSuccess: (UserCredential userCredential) {
            ShowSnackBar.showSnackBar(
              context,
              'Kayıt başarılı: ${userCredential.user?.email}',
            );
            Navigator.pop(context);
          },
        );
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Yeni Admin Ekle',
          style: AppTextStyles.appBar,
        ),
        const SizedBox(height: 10.0),
        CustomTextField(
          controller: nameController,
          label: 'Ad',
          multiline: false,
        ),
        const SizedBox(height: 10.0),
        CustomTextField(
          controller: surnameController,
          label: 'Soyisim',
          multiline: false,
        ),
        const SizedBox(height: 10.0),
        EmailField(controller: mailController),
        const SizedBox(height: 10.0),
        PhoneField(controller: phoneController),
        const SizedBox(height: 10.0),
        PasswordField(controller: passwordController),
        const Text('Admin Şifreniz'),
        PasswordField(controller: adminPasswordController),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: onSave,
          child: const Text("Kaydet"),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
