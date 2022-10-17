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
  BrandedTheme get brandedTheme;

  /// Model representation of the theme.
  AppTheme get theme;

  /// Theme data provided for theming the MaterialApp
  ThemeData get themeData;
}

@immutable

/// BrandedTheme
class BrandedTheme extends ThemeExtension<BrandedTheme> {
  /// Theme extension that determines the way each custom theme behaves.
  const BrandedTheme({
    required this.primaryColor,
    required this.textColor,
    required this.accentColor,
  });

  /// Primary color. Used as general background color.
  final Color? primaryColor;

  /// Text color. Used on texts and as accent color in buttons.
  final Color? textColor;

  /// Accent color. Used on cards and other places where
  /// [primaryColor] and [textColor] are already used.
  final Color? accentColor;

  @override
  BrandedTheme copyWith({
    Color? primaryColor,
    Color? textColor,
    Color? accentColor,
  }) {
    return BrandedTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      textColor: textColor ?? this.textColor,
      accentColor: accentColor ?? this.accentColor,
    );
  }

  @override
  BrandedTheme lerp(ThemeExtension<BrandedTheme>? other, double t) {
    if (other is! BrandedTheme) {
      return this;
    }
    return BrandedTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
    );
  }
}

/// Theme definition for AppTheme.plainLight
class PlainLightTheme extends DWITheme {
  @override
  String get name => AppTheme.plainLight.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.brandWhite,
        textColor: DWIColors.brandBlue,
        accentColor: Colors.white,
      );

  @override
  AppTheme get theme => AppTheme.plainLight;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.blueSwatch,
        extensions: <ThemeExtension<dynamic>>[
          brandedTheme,
        ],
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: brandedTheme.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: brandedTheme.primaryColor,
          elevation: 0,
          centerTitle: false,
          foregroundColor: brandedTheme.textColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline2: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline3: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline4: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: brandedTheme.textColor,
          ),
          headline6: TextStyle(
            color: brandedTheme.textColor,
          ),
          caption: TextStyle(
            color: brandedTheme.textColor,
          ),
          overline: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText1: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText2: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle1: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: brandedTheme.textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: brandedTheme.textColor,
          ),
        ),
        splashColor: brandedTheme.textColor?.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
            side: BorderSide(
              color: brandedTheme.textColor!,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: brandedTheme.textColor,
            foregroundColor: brandedTheme.primaryColor,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.darkSide
class DarkSideTheme extends DWITheme {
  @override
  String get name => AppTheme.darkSide.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.brandBlueTint1,
        textColor: DWIColors.brandWhite,
        accentColor: DWIColors.rhino,
      );

  @override
  AppTheme get theme => AppTheme.darkSide;

  @override
  ThemeData get themeData => ThemeData(
        extensions: <ThemeExtension<dynamic>>[
          brandedTheme,
        ],
        primarySwatch: DWIColors.cyanSwatch,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: brandedTheme.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: brandedTheme.primaryColor,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline2: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline3: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline4: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: brandedTheme.textColor,
          ),
          headline6: TextStyle(
            color: brandedTheme.textColor,
          ),
          caption: TextStyle(
            color: brandedTheme.textColor,
          ),
          overline: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText1: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText2: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle1: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: brandedTheme.textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: brandedTheme.textColor,
          ),
        ),
        splashColor: brandedTheme.textColor?.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
            side: BorderSide(
              color: brandedTheme.textColor!,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: brandedTheme.textColor,
            foregroundColor: DWIColors.brandBlue,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.passionRed
class PassionRedTheme extends DWITheme {
  @override
  String get name => AppTheme.passionRed.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.passionRed,
        textColor: DWIColors.brandWhite,
        accentColor: DWIColors.bittersweet,
      );

  @override
  AppTheme get theme => AppTheme.passionRed;

  @override
  ThemeData get themeData => ThemeData(
        extensions: <ThemeExtension<dynamic>>[
          brandedTheme,
        ],
        primarySwatch: DWIColors.passionRedSwatch,
        scaffoldBackgroundColor: brandedTheme.primaryColor,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        appBarTheme: AppBarTheme(
          backgroundColor: brandedTheme.primaryColor,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline2: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline3: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline4: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: brandedTheme.textColor,
          ),
          headline6: TextStyle(
            color: brandedTheme.textColor,
          ),
          caption: TextStyle(
            color: brandedTheme.textColor,
          ),
          overline: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText1: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText2: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle1: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: brandedTheme.textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: brandedTheme.textColor,
          ),
        ),
        splashColor: brandedTheme.textColor?.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
            side: BorderSide(
              color: brandedTheme.textColor!,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: brandedTheme.textColor,
            foregroundColor: brandedTheme.primaryColor,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.justPurple
class JustPurpleTheme extends DWITheme {
  @override
  String get name => AppTheme.justPurple.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.justPurple,
        textColor: DWIColors.brandWhite,
        accentColor: DWIColors.electricViolet,
      );

  @override
  AppTheme get theme => AppTheme.justPurple;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.justPurpleSwatch,
        extensions: <ThemeExtension<dynamic>>[
          brandedTheme,
        ],
        scaffoldBackgroundColor: brandedTheme.primaryColor,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        appBarTheme: AppBarTheme(
          backgroundColor: brandedTheme.primaryColor,
          foregroundColor: brandedTheme.textColor,
          elevation: 0,
          centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline2: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline3: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline4: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: brandedTheme.textColor,
          ),
          headline6: TextStyle(
            color: brandedTheme.textColor,
          ),
          caption: TextStyle(
            color: brandedTheme.textColor,
          ),
          overline: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText1: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText2: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle1: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: brandedTheme.textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: brandedTheme.textColor,
          ),
        ),
        splashColor: brandedTheme.textColor?.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
            side: BorderSide(
              color: brandedTheme.textColor!,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: brandedTheme.textColor,
            foregroundColor: brandedTheme.primaryColor,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.goldAmber
class GoldAmberTheme extends DWITheme {
  @override
  String get name => AppTheme.goldAmber.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.goldAmber,
        textColor: DWIColors.brandBlue,
        accentColor: Colors.white30,
      );

  @override
  AppTheme get theme => AppTheme.goldAmber;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.goldAmberSwatch,
        extensions: <ThemeExtension<dynamic>>[
          brandedTheme,
        ],
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: brandedTheme.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: brandedTheme.primaryColor,
          elevation: 0,
          centerTitle: false,
          foregroundColor: brandedTheme.textColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline2: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline3: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline4: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: brandedTheme.textColor,
          ),
          headline6: TextStyle(
            color: brandedTheme.textColor,
          ),
          caption: TextStyle(
            color: brandedTheme.textColor,
          ),
          overline: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText1: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText2: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle1: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: brandedTheme.textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: brandedTheme.textColor,
          ),
        ),
        splashColor: brandedTheme.textColor?.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
            side: BorderSide(
              color: brandedTheme.textColor!,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: brandedTheme.textColor,
            foregroundColor: brandedTheme.primaryColor,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}

/// Theme definition for AppTheme.happyCyan
class HappyCyanTheme extends DWITheme {
  @override
  String get name => AppTheme.happyCyan.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.brandCyan,
        textColor: DWIColors.brandBlue,
        accentColor: Colors.white30,
      );

  @override
  AppTheme get theme => AppTheme.happyCyan;

  @override
  ThemeData get themeData => ThemeData(
        primarySwatch: DWIColors.cyanSwatch,
        extensions: <ThemeExtension<dynamic>>[
          brandedTheme,
        ],
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: DWIFonts.appFont,
        scaffoldBackgroundColor: brandedTheme.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: brandedTheme.primaryColor,
          elevation: 0,
          centerTitle: false,
          foregroundColor: brandedTheme.textColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline2: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline3: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline4: TextStyle(
            color: brandedTheme.textColor,
          ),
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            color: brandedTheme.textColor,
          ),
          headline6: TextStyle(
            color: brandedTheme.textColor,
          ),
          caption: TextStyle(
            color: brandedTheme.textColor,
          ),
          overline: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText1: TextStyle(
            color: brandedTheme.textColor,
          ),
          bodyText2: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle1: TextStyle(
            color: brandedTheme.textColor,
          ),
          subtitle2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: brandedTheme.textColor,
          ),
          button: TextStyle(
            fontSize: 18,
            color: brandedTheme.textColor,
          ),
        ),
        splashColor: brandedTheme.textColor?.withOpacity(0.3),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
            side: BorderSide(
              color: brandedTheme.textColor!,
              width: 1.5,
            ),
            shape: const BeveledRectangleBorder(),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: brandedTheme.textColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: brandedTheme.textColor,
            foregroundColor: brandedTheme.primaryColor,
            shape: const BeveledRectangleBorder(),
          ),
        ),
      );
}
