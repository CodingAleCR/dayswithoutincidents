part of 'theme_chooser_cubit.dart';

/// ThemeChooserState
class ThemeChooserState extends Equatable {
  /// Holds the state for the theme.
  const ThemeChooserState({
    this.theme = AppTheme.plainLight,
  });

  /// Current theme been used.
  final AppTheme theme;

  @override
  List<Object> get props => [theme];

  /// Provides a cloned instance.
  ThemeChooserState copyWith({
    AppTheme? theme,
  }) {
    return ThemeChooserState(
      theme: theme ?? this.theme,
    );
  }
}
