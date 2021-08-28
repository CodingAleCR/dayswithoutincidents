import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'font.dart';

abstract class DWIThemes {
  static final allThemes = [
    PlainLightTheme(),
    TheDarksideTheme(),
    PassionRedTheme(),
    JustPurpleTheme(),
    GoldAmberTheme(),
    AnotherCyanTheme(),
  ];

  static DWITheme getTheme(AppTheme theme) =>
      allThemes.firstWhere((dwiTheme) => dwiTheme.theme == theme);

  static int getThemeIdx(AppTheme theme) =>
      allThemes.indexWhere((dwiTheme) => dwiTheme.theme == theme);

  static DWITheme nextTheme(AppTheme theme) {
    final currentThemeIdx = DWIThemes.getThemeIdx(theme);

    if (currentThemeIdx + 1 < DWIThemes.allThemes.length) {
      return DWIThemes.allThemes[currentThemeIdx + 1];
    } else {
      return DWIThemes.allThemes[0];
    }
  }
}

abstract class DWITheme {
  String get name;
  Color get color;
  AppTheme get theme;
  ThemeData get themeData;
}

class PlainLightTheme extends DWITheme {
  @override
  String get name => "Plain Light";

  @override
  Color get color => DWIColors.brandWhite;

  @override
  AppTheme get theme => AppTheme.plainLight;

  @override
  ThemeData get themeData => ThemeData(
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
}

class TheDarksideTheme extends DWITheme {
  @override
  String get name => "The Darkside";

  @override
  Color get color => DWIColors.brandBlueTint1;

  @override
  AppTheme get theme => AppTheme.theDarkside;

  @override
  ThemeData get themeData => ThemeData(
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

class PassionRedTheme extends DWITheme {
  @override
  String get name => "Passion Red";

  @override
  Color get color => DWIColors.passionRed;

  @override
  AppTheme get theme => AppTheme.passionRed;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.passionRedSwatch,
        scaffoldBackgroundColor: DWIColors.passionRed,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.APP_FONT,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          brightness: Brightness.dark,
          backgroundColor: DWIColors.passionRed,
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

class JustPurpleTheme extends DWITheme {
  @override
  String get name => "Just Purple";

  @override
  Color get color => DWIColors.justPurple;

  @override
  AppTheme get theme => AppTheme.justPurple;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.justPurpleSwatch,
        scaffoldBackgroundColor: DWIColors.justPurple,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.APP_FONT,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          brightness: Brightness.light,
          backgroundColor: DWIColors.justPurple,
          foregroundColor: DWIColors.brandWhite,
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

class GoldAmberTheme extends DWITheme {
  @override
  String get name => "Gold Amber";

  @override
  Color get color => DWIColors.goldAmber;

  @override
  AppTheme get theme => AppTheme.goldAmber;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.goldAmberSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.APP_FONT,
        scaffoldBackgroundColor: DWIColors.goldAmber,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          brightness: Brightness.light,
          backgroundColor: DWIColors.goldAmber,
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
}

class AnotherCyanTheme extends DWITheme {
  @override
  String get name => "Another Cyan";

  @override
  Color get color => DWIColors.brandCyan;

  @override
  AppTheme get theme => AppTheme.anotherCyan;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.cyanSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.APP_FONT,
        scaffoldBackgroundColor: DWIColors.brandCyan,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          brightness: Brightness.light,
          backgroundColor: DWIColors.brandCyan,
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
}
