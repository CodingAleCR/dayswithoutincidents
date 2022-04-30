import 'package:domain/domain.dart';
import 'package:dwi/core/env/environment.dart';
import 'package:dwi/core/localization/localization.dart';
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
    return BlocProvider(
      create: (_) => ThemeChooserCubit(
        context.read<TimeCounterService>(),
      )..fetchTheme(),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView({
    Key? key,
  }) : super(key: key);

  @override
  __AppViewState createState() => __AppViewState();
}

class __AppViewState extends State<_AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeChooserCubit>().state.theme;
    final themeData = DWIThemes.getTheme(theme).themeData;

    return Wiredash(
      projectId: EnvironmentConfig.wiredashProjectId,
      secret: EnvironmentConfig.wiredashSecret,
      navigatorKey: _navigatorKey,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        navigatorObservers: [SentryNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        title: 'Days Without Incidents',
        theme: themeData,
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
        home: MultiBlocProvider(
          providers: [
            BlocProvider<CounterListCubit>(
              create: (context) => CounterListCubit(
                RepositoryProvider.of<TimeCounterService>(context),
              )..fetchCounters(),
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );
  }
}
