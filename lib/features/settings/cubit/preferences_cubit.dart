import 'package:domain/domain.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'preferences_state.dart';

/// Handles logic around preferences of the user.
class PreferencesCubit extends Cubit<PreferencesState> {
  /// Handles logic around streaks of a counter.
  PreferencesCubit(
    this._preferencesService,
    this._counterService,
  ) : super(
          const PreferencesState(),
        );

  /// Service for interacting with counter restarts.
  final PreferencesService _preferencesService;

  /// Service for interacting with counters.
  final TimeCounterService _counterService;

  /// Fetches the different preferences of the user.
  Future<void> fetchPreferences() async {
    final preferredMode = await _preferencesService.findDisplayMode();
    final theme = await _fetchTheme(preferredMode);

    emit(
      state.copyWith(
        preferredMode: preferredMode,
        theme: theme,
      ),
    );
  }

  Future<AppTheme> _fetchTheme(DisplayModes layout) async {
    var theme = AppTheme.happyCyan;

    if (layout.isCarousel) {
      final allCounters = await _counterService.findAll();
      final firstCounter =
          allCounters.isEmpty ? TimeCounter.empty : allCounters.first;

      theme = firstCounter.theme;
    } else {
      theme = await _preferencesService.findDefaultTheme();
    }

    return theme;
  }

  /// Toggles the preferred mode for displaying counters.
  Future<void> togglePreferredDisplayMode() async {
    final preferredMode = state.preferredMode == DisplayModes.list
        ? DisplayModes.carousel
        : DisplayModes.list;

    await _preferencesService.setDisplayMode(
      preferredMode: preferredMode,
    );

    final theme = await _fetchTheme(preferredMode);

    emit(
      state.copyWith(
        preferredMode: preferredMode,
        theme: theme,
      ),
    );
  }

  /// Toggles current default theme
  Future<void> toggleTheme() async {
    final nextTheme = DWIThemes.nextTheme(state.theme);
    await _preferencesService.setDefaultTheme(defaultTheme: nextTheme.theme);
    emit(
      state.copyWith(
        theme: nextTheme.theme,
      ),
    );
  }
}
