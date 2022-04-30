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
  AppTheme get theme => AppTheme.plainLight;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.blueSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: DWIColors.brandWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: DWIColors.brandWhite,
          elevation: 0,
          centerTitle: false,
          foregroundColor: DWIColors.brandBlue,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: const TextTheme(
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
        splashColor: DWIColors.brandBlue.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: DWIColors.brandBlue,
            side: const BorderSide(
              color: DWIColors.brandBlue,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: DWIColors.brandBlue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: DWIColors.brandBlue,
            onPrimary: DWIColors.brandWhite,
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
  AppTheme get theme => AppTheme.darkSide;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.cyanSwatch,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: DWIColors.brandBlueTint1,
        appBarTheme: const AppBarTheme(
          backgroundColor: DWIColors.brandBlueTint1,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: const TextTheme(
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
        splashColor: DWIColors.brandWhite.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: DWIColors.brandWhite,
            side: const BorderSide(
              color: DWIColors.brandWhite,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: DWIColors.brandCyan,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: DWIColors.brandWhite,
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
  AppTheme get theme => AppTheme.passionRed;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.passionRedSwatch,
        scaffoldBackgroundColor: DWIColors.passionRed,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        appBarTheme: const AppBarTheme(
          backgroundColor: DWIColors.passionRed,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: const TextTheme(
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
        splashColor: DWIColors.brandWhite.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: DWIColors.brandWhite,
            side: const BorderSide(
              color: DWIColors.brandWhite,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: DWIColors.brandCyan,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: DWIColors.brandWhite,
            onPrimary: DWIColors.passionRed,
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
  AppTheme get theme => AppTheme.justPurple;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.justPurpleSwatch,
        scaffoldBackgroundColor: DWIColors.justPurple,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        appBarTheme: const AppBarTheme(
          backgroundColor: DWIColors.justPurple,
          foregroundColor: DWIColors.brandWhite,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: const TextTheme(
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
        splashColor: DWIColors.brandWhite.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: DWIColors.brandWhite,
            side: const BorderSide(
              color: DWIColors.brandWhite,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: DWIColors.brandWhite,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: DWIColors.brandWhite,
            onPrimary: DWIColors.justPurple,
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
  AppTheme get theme => AppTheme.goldAmber;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.goldAmberSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: DWIColors.goldAmber,
        appBarTheme: const AppBarTheme(
          backgroundColor: DWIColors.goldAmber,
          elevation: 0,
          centerTitle: false,
          foregroundColor: DWIColors.brandBlue,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: const TextTheme(
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
        splashColor: DWIColors.brandBlue.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: DWIColors.brandBlue,
            side: const BorderSide(
              color: DWIColors.brandBlue,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: DWIColors.brandBlue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: DWIColors.brandBlue,
            onPrimary: DWIColors.goldAmber,
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
  AppTheme get theme => AppTheme.happyCyan;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.cyanSwatch,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: DWIColors.brandCyan,
        appBarTheme: const AppBarTheme(
          backgroundColor: DWIColors.brandCyan,
          elevation: 0,
          centerTitle: false,
          foregroundColor: DWIColors.brandBlue,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: const TextTheme(
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
        splashColor: DWIColors.brandBlue.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: DWIColors.brandBlue,
            side: const BorderSide(
              color: DWIColors.brandBlue,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: DWIColors.brandBlue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: DWIColors.brandBlue,
            onPrimary: DWIColors.brandCyan,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}
