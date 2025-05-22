import 'package:flutter/material.dart';

import 'custom_text_fields.dart';

class PersonalInfoInputs extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const PersonalInfoInputs({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextFormField(
                controller: nameController,
                label: 'Ad',
                hint: 'Adınızı girin',
                multiline: false,
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              flex: 1,
              child: CustomTextFormField(
                controller: surnameController,
                label: 'Soyad',
                hint: 'Soyadınızı girin',
                multiline: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
        EmailField(controller: emailController, enabled: false),
        const SizedBox(height: 15.0),
        PhoneField(controller: phoneController, enabled: false),
      ],
    );
  }
}
