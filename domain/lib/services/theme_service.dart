import 'package:domain/domain.dart';

abstract class ThemeService {
  Future<AppTheme> getCurrentTheme();
  Future<void> setTheme(AppTheme theme);
}
