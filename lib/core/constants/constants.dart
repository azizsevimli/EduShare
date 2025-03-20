import 'package:flutter/material.dart';

class AppColors {
  static const Color vanilla = Color(0xFFE9DFAE);
  static const Color periwinkle = Color(0xFFCEC2FF);
  static const Color brown = Color(0xFFA77E58);
  static const Color orange = Color(0xFFE14F27);
  static const Color wine = Color(0xFF6B2737);
  static const Color white = Color(0xFFFFFFFF);
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

  static const TextStyle textButton = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.solid,
  );
}