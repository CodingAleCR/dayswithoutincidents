import 'package:domain/domain.dart';
import 'package:dwi/core/navigation/navigation.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/features/features.dart';
import 'package:environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wiredash/wiredash.dart';

/// DWI Application widget.
class DWIApplication extends StatelessWidget {
  /// @macro
  const DWIApplication({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider(
          create: (_) => ThemeChooserCubit(
            context.read<TimeCounterService>(),
            context.read<PreferencesService>(),
          )..fetchTheme(),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  /// Global navigator state to be used within the global app state.
  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeChooserCubit>().state.theme;
    final themeData = DWIThemes.getTheme(theme).themeData;

    return Wiredash(
      projectId: EnvironmentConfig.wiredashProjectId,
      secret: EnvironmentConfig.wiredashSecret,
      theme: WiredashThemeData.fromColor(
        primaryColor: DWIColors.brandCyan,
        brightness: Brightness.light,
      ),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        navigatorObservers: [SentryNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Days Without Incidents',
        theme: themeData,
        localizationsDelegates: S.localizationsDelegates,
        supportedLocales: S.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale != null) {
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
          }
          return supportedLocales.first;
        },
        home: BlocListener<NavigationCubit, Pages>(
          listener: (_, currentPage) {
            switch (currentPage) {
              case Pages.splash:
                _navigator?.pushAndRemoveUntil<void>(
                  SplashPage.route(),
                  (_) => false,
                );
              case Pages.counterList:
                _navigator?.pushAndRemoveUntil<void>(
                  CountersPage.route(),
                  (_) => false,
                );
              case Pages.settings:
                _navigator?.push<void>(SettingsPage.route());
              case Pages.streakList:
                // _navigator?.push<void>(StreaksPage.route());
                break;
              case Pages.restartsList:
                // _navigator?.push<void>(StreaksPage.route());
                break;
            }
          },
          child: const SplashPage(),
        ),
      ),
    );
  }
}
