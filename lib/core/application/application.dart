import 'package:domain/domain.dart';
import 'package:dwi/core/env/environment.dart';
import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/navigation/navigation.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wiredash/wiredash.dart';

/// DWI Application widget.
class DWIApplication extends StatelessWidget {
  /// @macro
  const DWIApplication({
    Key? key,
  }) : super(key: key);

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
          )..fetchTheme(),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({
    Key? key,
  }) : super(key: key);

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
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        navigatorObservers: [SentryNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Days Without Incidents',
        theme: themeData,
        // TODO(codingalecr): Migrate locales to ARB files.
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale != null) {
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
          }

          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
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
                break;
              case Pages.counterList:
                _navigator?.pushAndRemoveUntil<void>(
                  CountersPage.route(),
                  (_) => false,
                );
                break;
              case Pages.settings:
                _navigator?.push<void>(SettingsPage.route());
                break;
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
