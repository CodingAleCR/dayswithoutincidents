import 'dart:ui';

import 'package:flutter/material.dart';

import 'colors.dart';
import 'font.dart';

abstract class DWIThemes {
  static final light = ThemeData(
    primarySwatch: DWIColors.blueSwatch,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: DWIFonts.APP_FONT,
    scaffoldBackgroundColor: DWIColors.brandWhite,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      brightness: Brightness.light,
      backgroundColor: DWIColors.brandWhite,
      elevation: 0,
      centerTitle: false,
      foregroundColor: DWIColors.brandBlue,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: DWIColors.brandBlue,
      ),
      headline2: TextStyle(
        color: DWIColors.brandBlue,
      ),
      headline3: TextStyle(
        color: DWIColors.brandBlue,
      ),
      headline4: TextStyle(
        color: DWIColors.brandBlue,
      ),
      headline5: TextStyle(
        color: DWIColors.brandBlue,
      ),
      headline6: TextStyle(
        color: DWIColors.brandBlue,
      ),
      caption: TextStyle(
        color: DWIColors.brandBlue,
      ),
      overline: TextStyle(
        color: DWIColors.brandBlue,
      ),
      bodyText1: TextStyle(
        color: DWIColors.brandBlue,
      ),
      bodyText2: TextStyle(
        color: DWIColors.brandBlue,
      ),
      subtitle1: TextStyle(
        color: DWIColors.brandBlue,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: DWIColors.brandBlue,
      ),
      button: TextStyle(
        fontSize: 18,
        color: DWIColors.brandBlue,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: DWIColors.brandBlue,
        side: BorderSide(
          color: DWIColors.brandBlue,
          width: 1.5,
        ),
        shape: BeveledRectangleBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: DWIColors.brandBlue,
      ),
    ),
  );
  static final dark = ThemeData(
    primarySwatch: DWIColors.cyanSwatch,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: DWIFonts.APP_FONT,
    scaffoldBackgroundColor: DWIColors.brandBlueTint1,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      brightness: Brightness.dark,
      backgroundColor: DWIColors.brandBlueTint1,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: DWIColors.brandWhite,
      ),
      headline2: TextStyle(
        color: DWIColors.brandWhite,
      ),
      headline3: TextStyle(
        color: DWIColors.brandWhite,
      ),
      headline4: TextStyle(
        color: DWIColors.brandWhite,
      ),
      headline5: TextStyle(
        color: DWIColors.brandWhite,
      ),
      headline6: TextStyle(
        color: DWIColors.brandWhite,
      ),
      caption: TextStyle(
        color: DWIColors.brandWhite,
      ),
      overline: TextStyle(
        color: DWIColors.brandWhite,
      ),
      bodyText1: TextStyle(
        color: DWIColors.brandWhite,
      ),
      bodyText2: TextStyle(
        color: DWIColors.brandWhite,
      ),
      subtitle1: TextStyle(
        color: DWIColors.brandWhite,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: DWIColors.brandWhite,
      ),
      button: TextStyle(
        fontSize: 18,
        color: DWIColors.brandWhite,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: DWIColors.brandWhite,
        side: BorderSide(
          color: DWIColors.brandWhite,
          width: 1.5,
        ),
        shape: BeveledRectangleBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: DWIColors.brandCyan,
      ),
    ),
  );
}
