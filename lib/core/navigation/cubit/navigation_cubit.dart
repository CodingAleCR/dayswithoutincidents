import 'package:flutter_bloc/flutter_bloc.dart';

/// Possible pages
enum Pages {
  /// Splash page
  splash,

  /// Counter List page
  counterList,

  /// Streak List page
  streakList,

  /// Restarts List page
  restartsList,

  /// Settings page
  settings,
}

/// NavigationCubit
class NavigationCubit extends Cubit<Pages> {
  /// NavigationCubit
  ///
  /// Handles navigation inside the app.
  NavigationCubit() : super(Pages.splash);

  /// Navigates to the [page] given.
  void navigateTo(Pages page) => emit(page);
}
