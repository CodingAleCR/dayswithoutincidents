import 'package:data/local/shared_preferences/providers/providers.dart';
import 'package:domain/domain.dart';

/// Implementation of a preferences repository from shared preferences.
class PreferencesRepositoryImpl {
  /// Constructor
  PreferencesRepositoryImpl({
    PreferencesSharedPreferenceProvider? preferencesProvider,
  }) : _preferencesProvider =
            preferencesProvider ?? PreferencesSharedPreferenceProvider();

  final PreferencesSharedPreferenceProvider _preferencesProvider;

  /// Get preferred display mode stored or the default if there's none.
  Future<DisplayModes> getDisplayMode() =>
      _preferencesProvider.getDisplayMode();

  /// Stores preferred display mode in local key-value storage.
  Future<void> setDisplayMode(DisplayModes mode) =>
      _preferencesProvider.setDisplayMode(mode);

  /// Gets the current default theme to be used with list display mode.
  Future<AppTheme> getDefaultTheme() async {
    final key = await _preferencesProvider.getDefaultTheme();

    return AppTheme.fromString(key);
  }

  /// Stores preferred display mode in local key-value storage.
  Future<void> setDefaultTheme(AppTheme theme) =>
      _preferencesProvider.setDefaultTheme(theme.key());

  /// Deletes all preferences information from key-value storage.
  Future<void> clear() => _preferencesProvider.clear();
}
