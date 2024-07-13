import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Key for the title in shared prefs.
const String kDisplayMode = 'display_mode';
const String kDefaultTheme = 'default_theme';

///
class PreferencesSharedPreferenceProvider {
  /// Get preferred display mode stored or the default if there's none.
  Future<DisplayModes> getDisplayMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kDisplayMode)) {
      final rawPreferredMode = prefs.getString(kDisplayMode);
      final preferredMode = DisplayModes.values
          .firstWhere((mode) => mode.name == rawPreferredMode);

      return preferredMode;
    }
    return DisplayModes.carousel;
  }

  /// Stores preferred display mode in local key-value storage.
  Future<void> setDisplayMode(DisplayModes mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kDisplayMode, mode.name);
  }

  /// Get preferred display mode stored or the default if there's none.
  Future<String?> getDefaultTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(kDefaultTheme)) {
      final rawPreferredMode = prefs.getString(kDefaultTheme);

      return rawPreferredMode;
    }
    return null;
  }

  /// Stores preferred display mode in local key-value storage.
  Future<void> setDefaultTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kDefaultTheme, theme);
  }

  /// Deletes all preferences information from key-value storage.
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kDisplayMode);
    await prefs.remove(kDefaultTheme);
  }
}
