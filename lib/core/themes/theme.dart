import 'package:flutter/material.dart';
import 'package:edushare/core/constants/constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.orange,
      titleTextStyle: AppTextStyles.h2.copyWith(color: AppColors.white),
    ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.h1,
      headlineMedium: AppTextStyles.h2,
      headlineSmall: AppTextStyles.h3,
      bodyLarge: AppTextStyles.body1,
      bodyMedium: AppTextStyles.body2,
      bodySmall: AppTextStyles.body3,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      labelStyle: AppTextStyles.body1.copyWith(color: AppColors.black),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 1.5,
          color: AppColors.orange,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          width: 1.0,
          color: AppColors.black,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.orange),
        foregroundColor: WidgetStatePropertyAll(AppColors.white),
        textStyle: WidgetStatePropertyAll(
          AppTextStyles.body2,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.orange),
        textStyle: WidgetStatePropertyAll(
          AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
        maximumSize: WidgetStatePropertyAll(Size(double.infinity, 300)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        labelStyle: AppTextStyles.body1.copyWith(color: AppColors.black),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 1.5,
            color: AppColors.orange,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 1.0,
            color: AppColors.black,
          ),
        ),
        outlineBorder: BorderSide(
          width: 1.0,
          color: AppColors.black,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: 1.0,
            color: AppColors.black,
          ),
        ),
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      shape: CircularNotchedRectangle(),
      height: 60.0,
      color: AppColors.vanilla,
      shadowColor: AppColors.black,
      surfaceTintColor: AppColors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
      splashColor: AppColors.wine,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    ),
  );
}
