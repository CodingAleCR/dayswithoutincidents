enum AppTheme {
  plainLight,
  darkSide,
  passionRed,
  justPurple,
  goldAmber,
  happyCyan
}

extension AppThemeFromString on AppTheme {
  static AppTheme fromString(String? value) {
    switch (value) {
      case "plain_light":
        return AppTheme.plainLight;

      case "dark_side":
        return AppTheme.darkSide;

      case "passion_red":
        return AppTheme.passionRed;

      case "just_purple":
        return AppTheme.justPurple;

      case "gold_amber":
        return AppTheme.goldAmber;

      case "happy_cyan":
        return AppTheme.happyCyan;

      default:
        return AppTheme.happyCyan;
    }
  }

  String key() {
    switch (this) {
      case AppTheme.plainLight:
        return "plain_light";
      case AppTheme.darkSide:
        return "dark_side";
      case AppTheme.passionRed:
        return "passion_red";
      case AppTheme.justPurple:
        return "just_purple";
      case AppTheme.goldAmber:
        return "gold_amber";
      case AppTheme.happyCyan:
        return "happy_cyan";
    }
  }

  String get displayName {
    switch (this) {
      case AppTheme.plainLight:
        return "Plain Light";
      case AppTheme.darkSide:
        return "Dark Side";
      case AppTheme.passionRed:
        return "Passion Red";
      case AppTheme.justPurple:
        return "Just Purple";
      case AppTheme.goldAmber:
        return "Gold Amber";
      case AppTheme.happyCyan:
        return "Happy Cyan";
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
