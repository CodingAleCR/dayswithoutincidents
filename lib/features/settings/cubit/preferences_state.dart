part of 'preferences_cubit.dart';

/// State of [PreferencesCubit]
class PreferencesState extends Equatable {
  /// Holds information about preferences
  const PreferencesState({
    this.preferredMode = DisplayModes.carousel,
    this.theme = AppTheme.happyCyan,
  });

  /// Preferred display mode for counters.
  final DisplayModes preferredMode;

  /// Preferred theme for counters or the app.
  final AppTheme theme;

  @override
  List<Object> get props => [
        preferredMode,
        theme,
      ];

  /// Provides a cloned instance.
  PreferencesState copyWith({
    DisplayModes? preferredMode,
    AppTheme? theme,
  }) {
    return PreferencesState(
      preferredMode: preferredMode ?? this.preferredMode,
      theme: theme ?? this.theme,
    );
  }
}
