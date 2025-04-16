import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    /*---APPBAR---*/
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.tiffany,
      foregroundColor: AppColors.white,
      titleTextStyle: AppTextStyles.h2,
    ),
    /*---ICON---*/
    iconTheme: const IconThemeData(
      color: AppColors.black,
      size: 20,
    ),
    /*---INPUT---*/
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      prefixIconColor: AppColors.tiffany,
      labelStyle: AppTextStyles.body1.copyWith(color: AppColors.black),
      border: const OutlineInputBorder(),
      focusedBorder: focusedBorder(),
      enabledBorder: enabledBorder(),
      disabledBorder: disabledBorder(),
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
    /*---DROPDOWN-MENU---*/
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
        focusedBorder: focusedBorder(),
        enabledBorder: enabledBorder(),
        disabledBorder: disabledBorder(),
        outlineBorder: const BorderSide(
          width: 1.0,
          color: AppColors.black,
        ),
      ),
    ),
    /*---BOTTOM-APPBAR---*/
    bottomAppBarTheme: const BottomAppBarTheme(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      shape: CircularNotchedRectangle(),
      height: 60.0,
      color: AppColors.tiffany,
      shadowColor: AppColors.black,
      surfaceTintColor: AppColors.white,
    ),
    /*---FLOATING-BUTTON---*/
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.tiffany,
      foregroundColor: AppColors.white,
      splashColor: AppColors.lightTiffany,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
    ),
  );

  static OutlineInputBorder disabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: AppColors.grey,
      ),
    );
  }

  static OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: AppColors.black,
      ),
    );
  }

  static OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: AppColors.tiffany,
      ),
    );
  }
}
