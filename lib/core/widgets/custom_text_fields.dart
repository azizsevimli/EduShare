import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final String? title;
  final String? subtitle;
  final bool multiline;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.title,
    this.subtitle,
    required this.multiline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && subtitle != null)
          InputTitleSubtitle(
            title: title,
            subtitle: subtitle,
          ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType:
              multiline ? TextInputType.multiline : TextInputType.text,
          maxLines: multiline ? null : 1,
          maxLength: multiline ? 300 : null,
          textCapitalization: multiline
              ? TextCapitalization.sentences
              : TextCapitalization.words,
          decoration: InputDecoration(
            labelText: label ?? '',
            hintText: hint,
          ),
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final String? title;
  final String? subtitle;
  final bool multiline;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.label,
    this.title,
    this.subtitle,
    required this.multiline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && subtitle != null)
          InputTitleSubtitle(
            title: title,
            subtitle: subtitle,
          ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType:
              multiline ? TextInputType.multiline : TextInputType.text,
          maxLines: multiline ? null : 1,
          maxLength: multiline ? 300 : null,
          textCapitalization: multiline
              ? TextCapitalization.sentences
              : TextCapitalization.words,
          decoration: InputDecoration(
            labelText: label ?? '',
            hintText: hint,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bu alan boş bırakılamaz';
            }
            return null;
          },
        ),
      ],
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
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'E-posta',
        hintText: 'E-postanızı girin',
        prefixIcon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bu alan boş bırakılamaz';
        }
        return null;
      },
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
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Telefon',
        hintText: '5XX XXX XX XX',
        prefix: Text('+90'),
        prefixIcon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bu alan boş bırakılamaz';
        }
        return null;
      },
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
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bu alan boş bırakılamaz';
        }
        return null;
      },
    );
  }
}

class OnlyCostField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? title;
  final String? subtitle;

  const OnlyCostField({
    super.key,
    required this.controller,
    required this.hint,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && subtitle != null) ...[
          InputTitleSubtitle(
            title: title,
            subtitle: subtitle,
          ),
          const SizedBox(height: 5),
        ],
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: '0',
            suffixIcon: Icon(Icons.currency_lira_outlined),
            suffixIconColor: AppColors.tiffany,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bu alan boş bırakılamaz';
            }
            return null;
          },
        ),
      ],
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
            color: AppColors.xanthous,
          ),
        ),
      ],
    );
  }
}
