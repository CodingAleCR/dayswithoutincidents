import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wiredash/wiredash.dart';

import '../localization/localization.dart';
import '../theme/theme.dart';

class DWIApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeChooserCubit(context.read<ThemeService>()),
      child: _AppView(),
    );
  }
}

class _AppView extends StatefulWidget {
  _AppView({
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
      projectId: 'dwi-kepsf3w',
      secret: '4ehkp9jse3lgr3kqxr0ten7d9cgwbmem',
      navigatorKey: _navigatorKey,
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Days Without Incidents',
        theme: themeData,
        supportedLocales: [
          const Locale('en'),
          const Locale('es'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) {
            // If the locale of the device is not defined, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          } else {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            // If the locale of the device is not supported, use the first one
            // from the list (English, in this case).
            return supportedLocales.first;
          }
        },
        home: RepositoryProvider<TimeCounterService>(
          create: (context) => TimeCounterServiceImpl(),
          child: BlocProvider<TimeCounterCubit>(
            create: (context) => TimeCounterCubit(
              RepositoryProvider.of<TimeCounterService>(context),
            ),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
