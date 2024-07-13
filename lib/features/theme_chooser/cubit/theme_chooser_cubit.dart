import 'dart:async';

import 'package:domain/domain.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'theme_chooser_state.dart';

/// ThemeChooserCubit
class ThemeChooserCubit extends Cubit<ThemeChooserState> {
  /// Cubit for choosing a theme.
  ThemeChooserCubit(
    this._service,
    this._preferenceService,
  ) : super(const ThemeChooserState()) {
    _preferenceService.theme.listen((newTheme) {
      emit(state.copyWith(theme: newTheme));
    });
  }

  final TimeCounterService _service;
  final PreferencesService _preferenceService;

  /// Fetches the first time counter and sets it's theme to state.
  Future<void> fetchTheme() async {
    try {
      final currentMode = await _preferenceService.findDisplayMode();

      if (currentMode.isCarousel) {
        final allCounters = await _service.findAll();
        final firstCounter =
            allCounters.isEmpty ? TimeCounter.empty : allCounters.first;
        emit(
          state.copyWith(
            theme: firstCounter.theme,
          ),
        );
      } else {
        final theme = await _preferenceService.findDefaultTheme();
        emit(
          state.copyWith(
            theme: theme,
          ),
        );
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  /// Responds to user interactions that change the theme.
  Future<void> themeChanged(AppTheme theme) async {
    try {
      emit(
        state.copyWith(
          theme: theme,
        ),
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  /// Returns the next available custom theme as the current one.
  AppTheme nextTheme(AppTheme theme) {
    return DWIThemes.nextTheme(theme).theme;
  }

  /// Returns the next available custom theme as the current one.
  Future<void> nextDefaultTheme() async {
    final nextTheme = DWIThemes.nextTheme(state.theme);
    await _preferenceService.setDefaultTheme(defaultTheme: nextTheme.theme);
    emit(
      state.copyWith(
        theme: nextTheme.theme,
      ),
    );
  }
}
