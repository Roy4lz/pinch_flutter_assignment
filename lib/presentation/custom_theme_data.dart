import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomThemeData {
  static ThemeData getTheme(){
    return ThemeData(
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 25,
          color: ThemeColors.defaultFontColor,
          fontWeight: FontWeight.bold
        ),
        headlineMedium: TextStyle(
          fontSize: 30,
          color: ThemeColors.defaultFontColor,
          fontWeight: FontWeight.bold
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          color: ThemeColors.defaultFontColor,
          fontWeight: FontWeight.bold
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: ThemeColors.defaultFontColor
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: ThemeColors.lightFontColor
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
        backgroundColor:  ThemeColors.defaultButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40))
        ),
      ),
    );
  }
}