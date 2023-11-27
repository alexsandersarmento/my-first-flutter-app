import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/core/theme/app_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor:  AppColors.white,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: AppColors.white,
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    labelMedium: TextStyle(
      color: AppColors.black,
      fontSize: 18,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      color: AppColors.black,
    ),
    headlineSmall: TextStyle(
      color: AppColors.black,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 44),
       side: const BorderSide(
        color: AppColors.black,
        width: 0.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    background: AppColors.white,
    onPrimary: AppColors.white,
    secondary: AppColors.black,
    onBackground: AppColors.black,
    onError: AppColors.white,
    onSecondary: AppColors.white,
    onSurface: AppColors.black,
    error: AppColors.red,
    primary: AppColors.white,
    primaryContainer: AppColors.white,
    surface: AppColors.white,
    brightness: Brightness.light,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColors.black,
  scaffoldBackgroundColor: AppColors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.black,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: AppColors.black,
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: AppColors.white,
    ),
    labelMedium: TextStyle(
      color: AppColors.white,
      fontSize: 18,
    ),
    bodySmall: TextStyle(
      color: AppColors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 44),
      side: const BorderSide(
        color: AppColors.white,
        width: 0.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    background: AppColors.black,
    onPrimary: AppColors.black,
    secondary: AppColors.white,
    onBackground: AppColors.white,
    onError: AppColors.black,
    onSecondary: AppColors.black,
    onSurface: AppColors.white,
    error: AppColors.red,
    primary: AppColors.black,
    primaryContainer: AppColors.black,
    surface: AppColors.black,
    brightness: Brightness.dark,
  ),  
);
