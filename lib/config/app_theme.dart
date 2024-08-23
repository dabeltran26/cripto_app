import 'package:cripto_app/config/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return appTheme();
  }

  static ThemeData appTheme() {
    Color primaryColor = ColorsApp.primaryColor;

    final ThemeData base = ThemeData(
      useMaterial3: true,
      fontFamily: 'Manrope',
    );

    return base.copyWith(
        appBarTheme: AppBarTheme(
          color: ColorsApp.white,
          iconTheme: IconThemeData(color: primaryColor),
          shadowColor: ColorsApp.white,
          foregroundColor: ColorsApp.white,
          surfaceTintColor: ColorsApp.white,
        ),
        primaryColor: primaryColor);
  }
}
