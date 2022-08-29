import 'package:domain/domain.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/core/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom themes for DWI
abstract class DWIThemes {
  /// All available themes
  static final allThemes = [
    PlainLightTheme(),
    DarkSideTheme(),
    PassionRedTheme(),
    JustPurpleTheme(),
    GoldAmberTheme(),
    HappyCyanTheme(),
  ];

  /// Gets a theme based on the given [theme] model
  static DWITheme getTheme(AppTheme theme) =>
      allThemes.firstWhere((dwiTheme) => dwiTheme.theme == theme);

  /// Finds the index for a [theme]
  static int getThemeIdx(AppTheme theme) =>
      allThemes.indexWhere((dwiTheme) => dwiTheme.theme == theme);

  /// Returns the next theme according to the given [theme]'s index.
  static DWITheme nextTheme(AppTheme theme) {
    final currentThemeIdx = DWIThemes.getThemeIdx(theme);

    if (currentThemeIdx + 1 < DWIThemes.allThemes.length) {
      return DWIThemes.allThemes[currentThemeIdx + 1];
    } else {
      return DWIThemes.allThemes[0];
    }
  }
}

/// Defines how all custom themes should behave
abstract class DWITheme {
  /// Proper name of the theme
  String get name;

  /// Base color for the theme
  Color get color;

  /// Base color for the theme
  Color get textColor;

  /// Model representation of the theme.
  AppTheme get theme;

  /// Theme data provided for theming the MaterialApp
  ThemeData get themeData;
}

/// Theme definition for AppTheme.plainLight
class PlainLightTheme extends DWITheme {
  @override
  String get name => 'Plain Light';

  @override
  Color get color => DWIColors.brandWhite;

  @override
  Color get textColor => DWIColors.brandBlue;

  @override
  AppTheme get theme => AppTheme.plainLight;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.blueSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: color,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          elevation: 0,
          centerTitle: false,
          foregroundColor: textColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: textColor,
          ),
          headline2: TextStyle(
            color: textColor,
          ),
          headline3: TextStyle(
            color: textColor,
          ),
          headline4: TextStyle(
            color: textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headline6: TextStyle(
            color: textColor,
          ),
          caption: TextStyle(
            color: textColor,
          ),
          overline: TextStyle(
            color: textColor,
          ),
          bodyText1: TextStyle(
            color: textColor,
          ),
          bodyText2: TextStyle(
            color: textColor,
          ),
          subtitle1: TextStyle(
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        splashColor: textColor.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: textColor,
            side: BorderSide(
              color: textColor,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: textColor,
            onPrimary: color,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.darkSide
class DarkSideTheme extends DWITheme {
  @override
  String get name => 'The Darkside';

  @override
  Color get color => DWIColors.brandBlueTint1;

  @override
  Color get textColor => DWIColors.brandWhite;

  @override
  AppTheme get theme => AppTheme.darkSide;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.cyanSwatch,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: color,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: textColor,
          ),
          headline2: TextStyle(
            color: textColor,
          ),
          headline3: TextStyle(
            color: textColor,
          ),
          headline4: TextStyle(
            color: textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headline6: TextStyle(
            color: textColor,
          ),
          caption: TextStyle(
            color: textColor,
          ),
          overline: TextStyle(
            color: textColor,
          ),
          bodyText1: TextStyle(
            color: textColor,
          ),
          bodyText2: TextStyle(
            color: textColor,
          ),
          subtitle1: TextStyle(
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        splashColor: textColor.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: textColor,
            side: BorderSide(
              color: textColor,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: textColor,
            onPrimary: DWIColors.brandBlue,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.passionRed
class PassionRedTheme extends DWITheme {
  @override
  String get name => 'Passion Red';

  @override
  Color get color => DWIColors.passionRed;

  @override
  Color get textColor => DWIColors.brandWhite;

  @override
  AppTheme get theme => AppTheme.passionRed;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.passionRedSwatch,
        scaffoldBackgroundColor: color,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: textColor,
          ),
          headline2: TextStyle(
            color: textColor,
          ),
          headline3: TextStyle(
            color: textColor,
          ),
          headline4: TextStyle(
            color: textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headline6: TextStyle(
            color: textColor,
          ),
          caption: TextStyle(
            color: textColor,
          ),
          overline: TextStyle(
            color: textColor,
          ),
          bodyText1: TextStyle(
            color: textColor,
          ),
          bodyText2: TextStyle(
            color: textColor,
          ),
          subtitle1: TextStyle(
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        splashColor: textColor.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: textColor,
            side: BorderSide(
              color: textColor,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: color,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: textColor,
            onPrimary: color,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.justPurple
class JustPurpleTheme extends DWITheme {
  @override
  String get name => 'Just Purple';

  @override
  Color get color => DWIColors.justPurple;

  @override
  Color get textColor => DWIColors.brandWhite;

  @override
  AppTheme get theme => AppTheme.justPurple;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.justPurpleSwatch,
        scaffoldBackgroundColor: color,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: textColor,
          ),
          headline2: TextStyle(
            color: textColor,
          ),
          headline3: TextStyle(
            color: textColor,
          ),
          headline4: TextStyle(
            color: textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headline6: TextStyle(
            color: textColor,
          ),
          caption: TextStyle(
            color: textColor,
          ),
          overline: TextStyle(
            color: textColor,
          ),
          bodyText1: TextStyle(
            color: textColor,
          ),
          bodyText2: TextStyle(
            color: textColor,
          ),
          subtitle1: TextStyle(
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        splashColor: textColor.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: textColor,
            side: BorderSide(
              color: textColor,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: textColor,
            onPrimary: color,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.goldAmber
class GoldAmberTheme extends DWITheme {
  @override
  String get name => 'Gold Amber';

  @override
  Color get color => DWIColors.goldAmber;

  @override
  Color get textColor => DWIColors.brandBlue;

  @override
  AppTheme get theme => AppTheme.goldAmber;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.goldAmberSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: color,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          elevation: 0,
          centerTitle: false,
          foregroundColor: textColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: textColor,
          ),
          headline2: TextStyle(
            color: textColor,
          ),
          headline3: TextStyle(
            color: textColor,
          ),
          headline4: TextStyle(
            color: textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headline6: TextStyle(
            color: textColor,
          ),
          caption: TextStyle(
            color: textColor,
          ),
          overline: TextStyle(
            color: textColor,
          ),
          bodyText1: TextStyle(
            color: textColor,
          ),
          bodyText2: TextStyle(
            color: textColor,
          ),
          subtitle1: TextStyle(
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        splashColor: textColor.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: textColor,
            side: BorderSide(
              color: textColor,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: textColor,
            onPrimary: color,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.happyCyan
class HappyCyanTheme extends DWITheme {
  @override
  String get name => 'Another Cyan';

  @override
  Color get color => DWIColors.brandCyan;

  @override
  Color get textColor => DWIColors.brandBlue;

  @override
  AppTheme get theme => AppTheme.happyCyan;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.cyanSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: color,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          elevation: 0,
          centerTitle: false,
          foregroundColor: textColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: textColor,
          ),
          headline2: TextStyle(
            color: textColor,
          ),
          headline3: TextStyle(
            color: textColor,
          ),
          headline4: TextStyle(
            color: textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          headline6: TextStyle(
            color: textColor,
          ),
          caption: TextStyle(
            color: textColor,
          ),
          overline: TextStyle(
            color: textColor,
          ),
          bodyText1: TextStyle(
            color: textColor,
          ),
          bodyText2: TextStyle(
            color: textColor,
          ),
          subtitle1: TextStyle(
            color: textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        splashColor: textColor.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: textColor,
            side: BorderSide(
              color: textColor,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: textColor,
            onPrimary: color,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}
