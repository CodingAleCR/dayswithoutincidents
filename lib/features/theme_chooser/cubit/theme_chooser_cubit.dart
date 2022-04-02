import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:equatable/equatable.dart';

part 'theme_chooser_state.dart';

class ThemeChooserCubit extends Cubit<ThemeChooserState> {
  ThemeChooserCubit() : super(ThemeChooserState());

  Future<void> themeChanged(AppTheme theme) async {
    try {
      // await _themeService.setTheme(theme);
      emit(state.copyWith(
        theme: theme,
      ));
    } catch (e) {}
  }

  AppTheme nextTheme() {
    return DWIThemes.nextTheme(state.theme).theme;
  }
}
