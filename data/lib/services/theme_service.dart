import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeServiceImpl extends ThemeService {
  static String _theme = "app_theme";

  @override
  Future<AppTheme> getCurrentTheme() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey(_theme)) {
      String theme = _prefs.getString(_theme)!;
      return AppThemeFromString.fromString(theme);
    } else {
      return AppTheme.passionRed;
    }
  }

  @override
  Future<void> setTheme(AppTheme theme) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(_theme, theme.key());
  }
}
