import 'package:cart_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppAppBarTheme {
  static const AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}
