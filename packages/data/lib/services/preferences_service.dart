import 'dart:async';

import 'package:data/local/shared_preferences/shared_preferences.dart';
import 'package:domain/domain.dart';
import 'package:rxdart/rxdart.dart';

/// Service for handling counter restarts
class PreferencesServiceImpl extends PreferencesService {
  /// Constructor
  PreferencesServiceImpl({
    PreferencesRepositoryImpl? repository,
  }) : _repository = repository ?? PreferencesRepositoryImpl();

  final StreamController<AppTheme> _themeController = BehaviorSubject();

  @override
  Stream<AppTheme> get theme => _themeController.stream;

  final PreferencesRepositoryImpl _repository;

  @override
  Future<DisplayModes> findDisplayMode() => _repository.getDisplayMode();

  @override
  Future<void> setDisplayMode({required DisplayModes preferredMode}) =>
      _repository.setDisplayMode(preferredMode);

  @override
  Future<AppTheme> findDefaultTheme() async {
    final theme = await _repository.getDefaultTheme();
    _themeController.add(theme);
    return theme;
  }

  @override
  Future<void> setDefaultTheme({required AppTheme defaultTheme}) async {
    await _repository.setDefaultTheme(defaultTheme);
    _themeController.add(defaultTheme);
  }
}
