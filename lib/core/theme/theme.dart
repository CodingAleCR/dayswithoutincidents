import 'package:domain/domain.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/core/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom themes for DWI
abstract class DWIThemes {
  /// All available themes
  static final allThemes = [
    HappyCyanTheme(),
    PlainLightTheme(),
    DarkSideTheme(),
    PassionRedTheme(),
    JustPurpleTheme(),
    GoldAmberTheme(),
    DarkGoldTheme(),
    BloodRedTheme(),
    PurpleWhiteTheme(),
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
    // required this.backgroundColor,
  });

  /// Primary color. Used as general background color.
  final Color primaryColor;

  /// Text color. Used on texts and as accent color in buttons.
  final Color textColor;

  /// Accent color. Used on cards and other places where
  /// [primaryColor] and [textColor] are already used.
  final Color accentColor;

  /// Background color. Used for different surfaces as background color.
  // final Color backgroundColor;

  @override
  BrandedTheme copyWith({
    Color? primaryColor,
    Color? textColor,
    Color? accentColor,
    // Color? backgroundColor,
  }) {
    return BrandedTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      textColor: textColor ?? this.textColor,
      accentColor: accentColor ?? this.accentColor,
      // backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  BrandedTheme lerp(ThemeExtension<BrandedTheme>? other, double t) {
    if (other is! BrandedTheme) {
      return this;
    }
    return BrandedTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      // backgroundColor: Color.lerp(backgroundColor,
      // other.backgroundColor, t)!,
    );
  }
}

const _lightBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: DWIColors.brandWhite,
  surfaceTintColor: DWIColors.brandBlue,
);

const _darkBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: DWIColors.brandBlueTint1,
  surfaceTintColor: DWIColors.brandWhite,
);

const _lightDialogTheme = DialogTheme(
  backgroundColor: DWIColors.brandWhite,
  surfaceTintColor: DWIColors.brandBlue,
);

const _darkDialogTheme = DialogTheme(
  backgroundColor: DWIColors.brandBlueTint1,
  surfaceTintColor: DWIColors.brandWhite,
);

const _lightInputDecorationTheme = InputDecorationTheme(
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.zero,
  ),
);

const _darkInputDecorationTheme = InputDecorationTheme(
  fillColor: DWIColors.brandBlueTint1,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.zero,
  ),
);

ThemeData buildDWITheme({
  required BrandedTheme brandedTheme,
  required MaterialColor swatch,
  required DatePickerThemeData datePickerTheme,
  Brightness brightness = Brightness.light,
}) {
  final systemUiOverlayStyle = brightness == Brightness.light
      ? SystemUiOverlayStyle.dark
      : SystemUiOverlayStyle.light;

  final dialogTheme =
      brightness == Brightness.light ? _lightDialogTheme : _darkDialogTheme;
  final bottomSheetTheme = brightness == Brightness.light
      ? _lightBottomSheetTheme
      : _darkBottomSheetTheme;

  final inputDecorationTheme = brightness == Brightness.light
      ? _lightInputDecorationTheme.copyWith(
          prefixIconColor: brandedTheme.textColor,
        )
      : _darkInputDecorationTheme.copyWith(
          prefixIconColor: brandedTheme.textColor,
        );

  return ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: swatch,
      brightness: brightness,
    ),
    iconTheme: IconThemeData(color: brandedTheme.textColor),
    extensions: <ThemeExtension<dynamic>>[
      brandedTheme,
    ],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: DWIFonts.appFont,
    scaffoldBackgroundColor: brandedTheme.primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: brandedTheme.primaryColor,
      elevation: 0,
      centerTitle: false,
      foregroundColor: brandedTheme.textColor,
      systemOverlayStyle: systemUiOverlayStyle,
    ),
    bottomSheetTheme: bottomSheetTheme,
    dividerColor: brandedTheme.accentColor,
    dividerTheme: DividerThemeData(
      color: brandedTheme.accentColor,
    ),
    inputDecorationTheme: inputDecorationTheme,
    dialogTheme: dialogTheme,
    timePickerTheme: TimePickerThemeData(
      backgroundColor: brandedTheme.primaryColor,
      hourMinuteColor: brandedTheme.primaryColor,
      hourMinuteTextColor: brandedTheme.textColor,
      dayPeriodColor: brandedTheme.primaryColor,
      dayPeriodTextColor: brandedTheme.textColor,
      dialBackgroundColor: brandedTheme.accentColor,
      dialTextColor: brandedTheme.textColor,
      dialHandColor: brandedTheme.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.zero,
        fillColor: brandedTheme.primaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    ),
    datePickerTheme: datePickerTheme,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: brandedTheme.textColor,
      ),
      displayMedium: TextStyle(
        color: brandedTheme.textColor,
      ),
      displaySmall: TextStyle(
        color: brandedTheme.textColor,
      ),
      headlineMedium: TextStyle(
        color: brandedTheme.textColor,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.bold,
        color: brandedTheme.textColor,
      ),
      titleLarge: TextStyle(
        color: brandedTheme.textColor,
      ),
      titleMedium: TextStyle(
        color: brandedTheme.textColor,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: brandedTheme.textColor,
      ),
      bodyLarge: TextStyle(
        color: brandedTheme.textColor,
      ),
      bodyMedium: TextStyle(
        color: brandedTheme.textColor,
      ),
      bodySmall: TextStyle(
        color: brandedTheme.textColor,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        color: brandedTheme.textColor,
      ),
      labelMedium: TextStyle(
        color: brandedTheme.textColor,
      ),
      labelSmall: TextStyle(
        color: brandedTheme.textColor,
      ),
    ),
    splashColor: brandedTheme.textColor.withValues(alpha: 0.3),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: brandedTheme.textColor,
        side: BorderSide(
          color: brandedTheme.textColor,
          width: 1.5,
        ),
        shape: const ContinuousRectangleBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: 0,
        shape: const ContinuousRectangleBorder(),
        foregroundColor: brandedTheme.textColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: brandedTheme.textColor,
        foregroundColor: brandedTheme.primaryColor,
        shape: const ContinuousRectangleBorder(),
      ),
    ),
  );
}

/// Theme definition for AppTheme.plainLight
class PlainLightTheme extends DWITheme {
  @override
  String get name => AppTheme.plainLight.displayName;

  @override
  BrandedTheme get brandedTheme => const BrandedTheme(
        primaryColor: DWIColors.brandWhite,
        textColor: DWIColors.brandBlue,
        accentColor: Colors.white30,
      );

  @override
  AppTheme get theme => AppTheme.plainLight;

  @override
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.blueSwatch,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandWhite,
          surfaceTintColor: DWIColors.brandBlue,
          headerBackgroundColor: DWIColors.brandWhite,
          headerForegroundColor: DWIColors.brandBlueTint1,
          rangePickerBackgroundColor: DWIColors.brandWhite,
          rangePickerSurfaceTintColor: DWIColors.brandBlue,
          rangePickerHeaderBackgroundColor: DWIColors.brandWhite,
          rangePickerHeaderForegroundColor: DWIColors.brandBlueTint1,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
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
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.cyanSwatch,
        brightness: Brightness.dark,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandBlueTint1,
          surfaceTintColor: DWIColors.brandWhite,
          headerBackgroundColor: DWIColors.brandBlueTint1,
          headerForegroundColor: DWIColors.brandWhite,
          rangePickerBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerSurfaceTintColor: DWIColors.brandWhite,
          rangePickerHeaderBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerHeaderForegroundColor: DWIColors.brandWhite,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
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
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.passionRedSwatch,
        brightness: Brightness.dark,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandBlueTint1,
          surfaceTintColor: DWIColors.brandWhite,
          headerBackgroundColor: DWIColors.brandBlueTint1,
          headerForegroundColor: DWIColors.brandWhite,
          rangePickerBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerSurfaceTintColor: DWIColors.brandWhite,
          rangePickerHeaderBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerHeaderForegroundColor: DWIColors.brandWhite,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
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
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.justPurpleSwatch,
        brightness: Brightness.dark,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandBlueTint1,
          surfaceTintColor: DWIColors.brandWhite,
          headerBackgroundColor: DWIColors.brandBlueTint1,
          headerForegroundColor: DWIColors.brandWhite,
          rangePickerBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerSurfaceTintColor: DWIColors.brandWhite,
          rangePickerHeaderBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerHeaderForegroundColor: DWIColors.brandWhite,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
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
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.goldAmberSwatch,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandWhite,
          surfaceTintColor: DWIColors.brandBlue,
          headerBackgroundColor: DWIColors.brandWhite,
          headerForegroundColor: DWIColors.brandBlueTint1,
          rangePickerBackgroundColor: DWIColors.brandWhite,
          rangePickerSurfaceTintColor: DWIColors.brandBlue,
          rangePickerHeaderBackgroundColor: DWIColors.brandWhite,
          rangePickerHeaderForegroundColor: DWIColors.brandBlueTint1,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
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
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.cyanSwatch,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandWhite,
          surfaceTintColor: DWIColors.brandBlue,
          headerBackgroundColor: DWIColors.brandWhite,
          headerForegroundColor: DWIColors.brandBlueTint1,
          rangePickerBackgroundColor: DWIColors.brandWhite,
          rangePickerSurfaceTintColor: DWIColors.brandBlue,
          rangePickerHeaderBackgroundColor: DWIColors.brandWhite,
          rangePickerHeaderForegroundColor: DWIColors.brandBlueTint1,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
          ),
        ),
      );
}

/// Theme definition for AppTheme.goldAmberInverted
class DarkGoldTheme extends DWITheme {
  @override
  String get name => AppTheme.goldAmberInverted.displayName;

  @override
  BrandedTheme get brandedTheme => BrandedTheme(
        primaryColor: DWIColors.brandBlue,
        textColor: DWIColors.goldAmber,
        accentColor: DWIColors.goldAmber.withValues(alpha: 0.1),
      );

  @override
  AppTheme get theme => AppTheme.goldAmberInverted;

  @override
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.blueSwatch,
        brightness: Brightness.dark,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandWhite,
          surfaceTintColor: DWIColors.brandBlue,
          headerBackgroundColor: DWIColors.brandWhite,
          headerForegroundColor: DWIColors.brandBlueTint1,
          rangePickerBackgroundColor: DWIColors.brandWhite,
          rangePickerSurfaceTintColor: DWIColors.brandBlue,
          rangePickerHeaderBackgroundColor: DWIColors.brandWhite,
          rangePickerHeaderForegroundColor: DWIColors.brandBlueTint1,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
          ),
        ),
      );
}

/// Theme definition for AppTheme.passionRedInverted
class BloodRedTheme extends DWITheme {
  @override
  String get name => AppTheme.passionRedInverted.displayName;

  @override
  BrandedTheme get brandedTheme => BrandedTheme(
        primaryColor: DWIColors.passionRedDark,
        textColor: DWIColors.bittersweet,
        accentColor: DWIColors.bittersweet.withValues(alpha: 0.1),
      );

  @override
  AppTheme get theme => AppTheme.passionRedInverted;

  @override
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.blueSwatch,
        brightness: Brightness.dark,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandBlueTint1,
          surfaceTintColor: DWIColors.brandWhite,
          headerBackgroundColor: DWIColors.brandBlueTint1,
          headerForegroundColor: DWIColors.brandWhite,
          rangePickerBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerSurfaceTintColor: DWIColors.brandWhite,
          rangePickerHeaderBackgroundColor: DWIColors.brandBlueTint1,
          rangePickerHeaderForegroundColor: DWIColors.brandWhite,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
          ),
        ),
      );
}

/// Theme definition for AppTheme.justPurple
class PurpleWhiteTheme extends DWITheme {
  @override
  String get name => AppTheme.justPurpleInverted.displayName;

  @override
  BrandedTheme get brandedTheme => BrandedTheme(
        primaryColor: DWIColors.brandWhite,
        textColor: DWIColors.justPurple,
        accentColor: DWIColors.justPurple.withValues(alpha: 0.1),
      );

  @override
  AppTheme get theme => AppTheme.justPurpleInverted;

  @override
  ThemeData get themeData => buildDWITheme(
        swatch: DWIColors.justPurpleSwatch,
        brandedTheme: brandedTheme,
        datePickerTheme: DatePickerThemeData(
          backgroundColor: DWIColors.brandWhite,
          surfaceTintColor: DWIColors.brandBlue,
          headerBackgroundColor: DWIColors.brandWhite,
          headerForegroundColor: DWIColors.brandBlueTint1,
          rangePickerBackgroundColor: DWIColors.brandWhite,
          rangePickerSurfaceTintColor: DWIColors.brandBlue,
          rangePickerHeaderBackgroundColor: DWIColors.brandWhite,
          rangePickerHeaderForegroundColor: DWIColors.brandBlueTint1,
          rangeSelectionBackgroundColor: brandedTheme.primaryColor.withValues(
            alpha: 0.3,
          ),
          dayBackgroundColor: WidgetStateColor.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? brandedTheme.primaryColor
                : Colors.transparent,
          ),
        ),
      );
}
