part of 'theme_chooser_cubit.dart';

class ThemeChooserState extends Equatable {
  const ThemeChooserState({
    this.theme = AppTheme.happyCyan,
  });

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
