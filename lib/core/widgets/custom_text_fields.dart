import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final bool ml;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    required this.ml,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: ml ? TextInputType.multiline : TextInputType.text,
      maxLines: ml ? null : 1,
      maxLength: ml ? 300 : null,
      textCapitalization: ml ? TextCapitalization.sentences : TextCapitalization.words,
      decoration: InputDecoration(
        labelText: label ?? '',
        hintText: hint,
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final bool? enabled;

  const EmailField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'E-posta',
        hintText: 'E-postanızı girin',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool? enabled;

  const PhoneField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Telefon',
        hintText: '5XX XXX XX XX',
        prefix: Text('+90'),
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordVisible = true;

  void passwordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: 'Şifre',
        hintText: 'Şifrenizi girin',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: passwordVisibility,
        ),
      ),
    );
  }
}

class OnlyCostField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const OnlyCostField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: '0',
        suffixIcon: Icon(Icons.currency_lira_outlined),
        suffixIconColor: AppColors.orange,
      ),
    );
  }
}

class InputTitleSubtitle extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const InputTitleSubtitle({
    super.key,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: AppTextStyles.body1.copyWith(
            color: AppColors.wine,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle!,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.brown,
          ),
        ),
      ],
    );
  }
}
