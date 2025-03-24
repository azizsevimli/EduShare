import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
      titleTextStyle: AppTextStyles.h2,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.black,
      size: 20,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      prefixIconColor: AppColors.orange,
      labelStyle: AppTextStyles.body1.copyWith(color: AppColors.black),
      border: const OutlineInputBorder(),
      focusedBorder: focusedOIB(),
      enabledBorder: enabledOIB(),
    ),
    /*---ELEVATED-BUTTON---*/
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        iconSize: 20,
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: AppColors.periwinkle,
        foregroundColor: AppColors.wine,
        overlayColor: AppColors.darkPeriwinkle,
        shadowColor: AppColors.lightPeriwinkle,
        iconColor: AppColors.wine,
        textStyle: AppTextStyles.body2,
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    /*---TEXT-BUTTON---*/
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: 2,
        iconSize: 20,
        animationDuration: const Duration(milliseconds: 500),
        foregroundColor: AppColors.wine,
        iconColor: AppColors.wine,
        textStyle: AppTextStyles.textButton,
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    /*---ICON-BUTTON---*/
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        elevation: 2,
        iconSize: 20,
        animationDuration: const Duration(milliseconds: 500),
        foregroundColor: AppColors.white,
        overlayColor: AppColors.grey,
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: const MenuStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
        maximumSize: WidgetStatePropertyAll(Size(double.infinity, 300)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        labelStyle: AppTextStyles.body1.copyWith(color: AppColors.black),
        border: const OutlineInputBorder(),
        focusedBorder: focusedOIB(),
        enabledBorder: enabledOIB(),
        disabledBorder: disabledOIB(),
        outlineBorder: const BorderSide(
          width: 1.0,
          color: AppColors.black,
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      shape: CircularNotchedRectangle(),
      height: 60.0,
      color: AppColors.vanilla,
      shadowColor: AppColors.black,
      surfaceTintColor: AppColors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.white,
      splashColor: AppColors.lightOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    ),
  );

  static OutlineInputBorder disabledOIB() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: AppColors.grey,
      ),
    );
  }

  static OutlineInputBorder enabledOIB() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1.2,
        color: AppColors.black,
      ),
    );
  }

  static OutlineInputBorder focusedOIB() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1.5,
        color: AppColors.orange,
      ),
    );
  }
}
