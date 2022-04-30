/// Lists all possible custom themes in the app.
enum AppTheme {
  /// White background with brand blue foreground.
  plainLight,

  /// Dark background with white foreground.
  darkSide,

  /// Red background with proper accesible foreground.
  passionRed,

  /// Purple background with proper accesible foreground.
  justPurple,

  /// Gold/Amber background with proper accesible foreground.
  goldAmber,

  /// Cyan background with proper accesible foreground.
  happyCyan
}

/// Converts a value into a string and viceversa.
extension AppThemeFromString on AppTheme {
  /// Parses a string into a valid AppTheme.
  static AppTheme fromString(String? value) {
    switch (value) {
      case 'plain_light':
        return AppTheme.plainLight;

      case 'dark_side':
        return AppTheme.darkSide;

      case 'passion_red':
        return AppTheme.passionRed;

      case 'just_purple':
        return AppTheme.justPurple;

      case 'gold_amber':
        return AppTheme.goldAmber;

      case 'happy_cyan':
        return AppTheme.happyCyan;

      default:
        return AppTheme.happyCyan;
    }
  }

  /// Returns the storage key of a valid AppTheme.
  String key() {
    switch (this) {
      case AppTheme.plainLight:
        return 'plain_light';
      case AppTheme.darkSide:
        return 'dark_side';
      case AppTheme.passionRed:
        return 'passion_red';
      case AppTheme.justPurple:
        return 'just_purple';
      case AppTheme.goldAmber:
        return 'gold_amber';
      case AppTheme.happyCyan:
        return 'happy_cyan';
    }
  }

  /// Returns the user front name of a given theme.
  String get displayName {
    switch (this) {
      case AppTheme.plainLight:
        return 'Plain Light';
      case AppTheme.darkSide:
        return 'Dark Side';
      case AppTheme.passionRed:
        return 'Passion Red';
      case AppTheme.justPurple:
        return 'Just Purple';
      case AppTheme.goldAmber:
        return 'Gold Amber';
      case AppTheme.happyCyan:
        return 'Happy Cyan';
    }
  }

  /// Helper to determine if theme is plain light.
  bool get isPlainLight => this == AppTheme.plainLight;

  /// Helper to determine if theme is the darkside.
  bool get isTheDarkside => this == AppTheme.darkSide;

  /// Helper to determine if theme is passion red.
  bool get isPassionRed => this == AppTheme.passionRed;

  /// Helper to determine if theme is just purple.
  bool get isJustPurple => this == AppTheme.justPurple;

  /// Helper to determine if theme is gold amber.
  bool get isGoldAmber => this == AppTheme.goldAmber;

  /// Helper to determine if theme is another cyan.
  bool get isAnotherCyan => this == AppTheme.happyCyan;
}
