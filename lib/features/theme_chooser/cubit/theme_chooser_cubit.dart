import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:equatable/equatable.dart';

part 'theme_chooser_state.dart';

class ThemeChooserCubit extends Cubit<ThemeChooserState> {
  ThemeChooserCubit(this._service) : super(ThemeChooserState());

  TimeCounterService _service;

  Future<void> fetchTheme() async {
    try {
      final allCounters = await _service.findAll();
      final firstCounter =
          allCounters.isEmpty ? TimeCounter.empty : allCounters.first;
      emit(state.copyWith(
        theme: firstCounter.theme,
      ));
    } catch (e) {}
  }

  Future<void> themeChanged(AppTheme theme) async {
    try {
      emit(state.copyWith(
        theme: theme,
      ));
    } catch (e) {}
  }

  AppTheme nextTheme() {
    return DWIThemes.nextTheme(state.theme).theme;
  }
}
