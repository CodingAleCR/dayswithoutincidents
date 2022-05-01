import 'package:bloc/bloc.dart';

/// Possible pages
enum Pages {
  /// Splash page
  splash,

  /// Counter List page
  counterList,

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
