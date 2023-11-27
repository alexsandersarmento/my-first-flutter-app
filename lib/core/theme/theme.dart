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
    bodySmall: TextStyle(
      color: AppColors.black,
      backgroundColor: AppColors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      side: const BorderSide(
        color: AppColors.black,
        width: 0.5,
      ),
      minimumSize: const Size(double.infinity, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
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
    bodySmall: TextStyle(
      color: AppColors.white,
      backgroundColor: AppColors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: AppColors.black,
      foregroundColor: AppColors.white,
      side: const BorderSide(
        color: AppColors.white,
        width: 0.5,
      ),
      minimumSize: const Size(double.infinity, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
