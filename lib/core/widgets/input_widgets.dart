import 'package:flutter/material.dart';

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
        prefixIcon: Icon(Icons.lock),
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

class EmailField extends StatefulWidget {
  final TextEditingController controller;

  const EmailField({
    super.key,
    required this.controller,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-posta',
        hintText: 'E-postanızı girin',
        prefixIcon: Icon(Icons.email),
      ),
    );
  }
}

class OnlyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const OnlyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  State<OnlyTextField> createState() => _OnlyTextFieldState();
}

class _OnlyTextFieldState extends State<OnlyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
      ),
    );
  }
}

class PhoneField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneField({
    super.key,
    required this.controller,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Telefon',
        prefix: Text('+90'),
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }
}
