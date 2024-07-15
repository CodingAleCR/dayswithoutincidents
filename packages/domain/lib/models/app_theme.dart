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
  happyCyan,

  /// Inverted theme of gold amber.
  goldAmberInverted,

  /// Inverted theme of passion red.
  passionRedInverted,

  /// Inverted theme of just purple.
  justPurpleInverted;

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

      case 'gold_amber_inverted':
        return AppTheme.goldAmberInverted;

      case 'passion_red_inverted':
        return AppTheme.passionRedInverted;

      case 'just_purple_inverted':
        return AppTheme.justPurpleInverted;

      default:
        return AppTheme.happyCyan;
    }
  }

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
      case AppTheme.goldAmberInverted:
        return 'gold_amber_inverted';
      case AppTheme.passionRedInverted:
        return 'passion_red_inverted';
      case AppTheme.justPurpleInverted:
        return 'just_purple_inverted';
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
      case AppTheme.goldAmberInverted:
        return 'Dark Gold';
      case AppTheme.passionRedInverted:
        return 'Blood Red';
      case AppTheme.justPurpleInverted:
        return 'Light Purple';
    }
  }
}
