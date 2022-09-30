import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app_colors.dart';
import './auto_responsive/auto_responsive.dart';
import '../utils/extensions/extensions.dart';

class CustomTheme {
  static const String appFontFamily = 'Manrope';

  static ThemeData getLightTheme() {
    const primaryColor = AppColors.primaryColor;
    const accentColor = AppColors.primaryLightColor;
    final colorSwatch = primaryColor.toMaterialColor();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primarySwatch: colorSwatch,
      fontFamily: appFontFamily,
      canvasColor: AppColors.white,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: colorSwatch.shade500,
        brightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionHandleColor: primaryColor,
        selectionColor: primaryColor.withOpacity(0.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: primaryColor,
        fillColor: accentColor,
        labelStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.gray,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 16.ms,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        helperStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.blue,
          fontWeight: FontWeight.w300,
        ),
        hintStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.gray,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.red,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: primaryColor, width: 2.s),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.gray, width: 2.s),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.blue, width: 2.s),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.red, width: 2.s),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.red, width: 2.s),
        ),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: AppColors.primaryLightColor,
        iconColor: AppColors.black,
        textColor: AppColors.black,
        dense: true,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.only(left: 16.s),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.gray,
        thickness: 0.5.s,
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        foregroundColor: AppColors.transparent,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20.ms),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99.s),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled)
                ? primaryColor.withOpacity(0.5)
                : primaryColor;
          }),
        ),
      ),
      textTheme: TextTheme(
        caption: TextStyle(
          color: AppColors.white,
          fontSize: 14.ms,
        ),
        overline: TextStyle(
          color: AppColors.black,
          fontSize: 14.ms,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryColor,
        actionTextColor: accentColor,
        disabledActionTextColor: AppColors.gray,
        contentTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 16.ms,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    const primaryColor = AppColors.primaryColor;
    const accentColor = AppColors.primaryLightColor;
    final colorSwatch = primaryColor.toMaterialColor();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primarySwatch: colorSwatch,
      fontFamily: appFontFamily,
      canvasColor: AppColors.offBlack,
      backgroundColor: AppColors.offBlack,
      scaffoldBackgroundColor: AppColors.offBlack,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: colorSwatch.shade500,
        brightness: Brightness.dark,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionHandleColor: primaryColor,
        selectionColor: primaryColor.withOpacity(0.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: accentColor,
        fillColor: primaryColor,
        labelStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.white,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 16.ms,
          color: accentColor,
          fontWeight: FontWeight.bold,
        ),
        helperStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.blue,
          fontWeight: FontWeight.w300,
        ),
        hintStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(
          fontSize: 14.ms,
          color: AppColors.red,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: accentColor, width: 2.s),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.gray, width: 2.s),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.blue, width: 2.s),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.red, width: 2.s),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(99.s)),
          borderSide: BorderSide(color: AppColors.red, width: 2.s),
        ),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: AppColors.primaryLightColor,
        iconColor: AppColors.white,
        textColor: AppColors.white,
        dense: true,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.only(left: 16.s),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.white,
        thickness: 0.5.s,
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        foregroundColor: AppColors.transparent,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: TextStyle(color: AppColors.white, fontSize: 20.ms),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99.s),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled)
                ? primaryColor.withOpacity(0.5)
                : primaryColor;
          }),
        ),
      ),
      textTheme: TextTheme(
        caption: TextStyle(
          color: AppColors.black,
          fontSize: 14.ms,
        ),
        overline: TextStyle(
          color: AppColors.white,
          fontSize: 14.ms,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: accentColor,
        actionTextColor: primaryColor,
        disabledActionTextColor: AppColors.gray,
        contentTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 16.ms,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
