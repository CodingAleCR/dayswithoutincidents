enum AppTheme {
  plainLight,
  theDarkside,
  passionRed,
  justPurple,
  goldAmber,
  anotherCyan
}

extension AppThemeFromString on AppTheme {
  static AppTheme fromString(String value) {
    switch (value) {
      case "plain_light":
        return AppTheme.plainLight;

      case "the_darkside":
        return AppTheme.theDarkside;

      case "passion_red":
        return AppTheme.passionRed;

      case "just_purple":
        return AppTheme.justPurple;

      case "gold_amber":
        return AppTheme.goldAmber;

      case "another_cyan":
        return AppTheme.anotherCyan;

      default:
        return AppTheme.plainLight;
    }
  }

  String key() {
    switch (this) {
      case AppTheme.plainLight:
        return "plain_light";
      case AppTheme.theDarkside:
        return "the_darkside";
      case AppTheme.passionRed:
        return "passion_red";
      case AppTheme.justPurple:
        return "just_purple";
      case AppTheme.goldAmber:
        return "gold_amber";
      case AppTheme.anotherCyan:
        return "another_cyan";
    }
  }

  /// Helper to determine if theme is plain light.
  bool get isPlainLight => this == AppTheme.plainLight;

  /// Helper to determine if theme is the darkside.
  bool get isTheDarkside => this == AppTheme.theDarkside;

  /// Helper to determine if theme is passion red.
  bool get isPassionRed => this == AppTheme.passionRed;

  /// Helper to determine if theme is just purple.
  bool get isJustPurple => this == AppTheme.justPurple;

  /// Helper to determine if theme is gold amber.
  bool get isGoldAmber => this == AppTheme.goldAmber;

  /// Helper to determine if theme is another cyan.
  bool get isAnotherCyan => this == AppTheme.anotherCyan;
}
