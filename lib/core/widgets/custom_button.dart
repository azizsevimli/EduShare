import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Color? fgColor;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.width,
    this.height,
    this.bgColor,
    this.fgColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? AppColors.periwinkle,
          foregroundColor: fgColor ?? AppColors.wine,
          iconColor: fgColor ?? AppColors.wine,
          textStyle: textStyle ?? AppTextStyles.body2,
          iconSize: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 10),
            ],
            Text(text!),
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? fgColor;
  final TextStyle? textStyle;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.fgColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bgColor ?? AppColors.white,
        foregroundColor: fgColor ?? AppColors.wine,
        textStyle: textStyle ?? AppTextStyles.textButton,
      ),
      child: Text(text),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? text;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? bgColor;
  final Color? fgColor;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.width,
    this.height,
    this.bgColor,
    this.fgColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 40,
      height: height ?? 40,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: bgColor ?? AppColors.white,
          foregroundColor: fgColor ?? AppColors.periwinkle,
          iconColor: fgColor ?? AppColors.periwinkle,
          side: BorderSide(color: fgColor ?? AppColors.periwinkle),
          textStyle: textStyle ?? AppTextStyles.body2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon),
              if (text != null) ...[
                const SizedBox(width: 10),
                Text(text!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
