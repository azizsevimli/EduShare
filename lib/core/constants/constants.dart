import 'package:flutter/material.dart';

String appName = 'eduShare';

String defaultProfileImageUrl = 'https://firebasestorage.googleapis.com/v0/b/edushare-cfca8.firebasestorage.app/o/users%2Fdefault_image.jpg?alt=media&token=6590c09a-04b4-4bc2-a205-e7e5b6b0873a';

class AppColors {
  static const Color lightPeriwinkle = Color(0xFFE7E1FF);
  static const Color periwinkle = Color(0xFFCEC2FF);
  static const Color darkPeriwinkle = Color(0xFF676180);
  static const Color lightTiffany = Color(0xFFC0E9E3);
  static const Color tiffany = Color(0xFF81D2C7);
  static const Color darkTiffany = Color(0xFF416964);
  static const Color lightXanthous = Color(0xFFFFE0AF);
  static const Color xanthous = Color(0xFFFFC15E);
  static const Color darkXanthous = Color(0xFF80612F);
  static const Color lightWine = Color(0xFFB5939B);
  static const Color lightRose = Color(0xFFE7BCB5);
  static const Color rose = Color(0xFFCE796B);
  static const Color darkRose = Color(0xFF673D36);
  static const Color wine = Color(0xFF6B2737);
  static const Color darkWine = Color(0xFF36141C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF7E7E7E);
  static const Color red = Color(0xFFD32F2F);
  static const Color black = Color(0xFF000000);
}

class AppTextStyles {
  static const TextStyle h1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10.0,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle appBar = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.wine,
  );

  static const TextStyle textButton = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.solid,
  );
}
