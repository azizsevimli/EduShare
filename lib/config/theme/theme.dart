import 'package:flutter/material.dart';

/*----Colors----*/
class AppColor {
  AppColor._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightOrange = Color(0xFFdd9f8e);
  static const Color orange = Color(0xFFba3f1d);
  static const Color darkOrange = Color(0xFF5d200f);
  static const Color lightGray = Color(0xFFa6b5b6);
  static const Color gray = Color(0xFF4d6a6d);
  static const Color darkGray = Color(0xFF273537);
  static const Color lightBrown = Color(0xFFd3bfac);
  static const Color brown = Color(0xFFa77e58);
  static const Color darkBrown = Color(0xFF543f2c);
  static const Color lightBeige = Color(0xFFf4efd7);
  static const Color beige = Color(0xFFe9dfae);
  static const Color darkBeige = Color(0xFF757057);
  static const Color lightBone = Color(0xFFece7e0);
  static const Color bone = Color(0xFFd9cfc1);
  static const Color darkBone = Color(0xFF6d6861);
}

/*----Text----*/
class AppTxtStyle {
  AppTxtStyle._();

  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w300,
  );
}

/*----Theme----*/
class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    fontFamily: 'Raleway',
    scaffoldBackgroundColor: AppColor.lightBone,
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleSpacing: 20,
      toolbarHeight: 80,
      centerTitle: false,
      scrolledUnderElevation: 0,
      shadowColor: AppColor.darkBone,
      backgroundColor: AppColor.white,
      foregroundColor: AppColor.orange,
      surfaceTintColor: AppColor.lightBone,
      actionsIconTheme: const IconThemeData(size: 24),
      titleTextStyle: AppTxtStyle.h2.copyWith(color: AppColor.orange),
    ),
    iconTheme: const IconThemeData(
      size: 24,
      color: AppColor.orange,
    ),
  );
}
