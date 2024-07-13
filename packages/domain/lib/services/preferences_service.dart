import 'package:domain/domain.dart';

/// Defines the behavior of a preferences service.
abstract class PreferencesService {
// /// Provides a [Stream] of all time counters.
//   Stream<DisplayModes> get displayMode;
  Stream<AppTheme> get theme;

  /// Finds the preferred display mode setting of the user.
  Future<DisplayModes> findDisplayMode();

  /// Sets the preferred display mode setting of the user.
  Future<void> setDisplayMode({
    required DisplayModes preferredMode,
  });

  /// Finds the default theme to be used with list display mode.
  Future<AppTheme> findDefaultTheme();

  /// Sets the default theme setting of the user.
  Future<void> setDefaultTheme({
    required AppTheme defaultTheme,
  });
}
