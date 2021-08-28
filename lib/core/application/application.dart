import 'package:domain/domain.dart';
import 'package:data/data.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:dwi/features/time_counter/time_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../localization/localization.dart';
import '../theme/theme.dart';

class DWIApplication extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeChooserCubit(context.read<ThemeService>()),
      child: _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeChooserCubit>().state.theme;
    final themeData = DWIThemes.getTheme(theme).themeData;

    return MaterialApp(
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
        child: BlocProvider<TimeCounterBloc>(
          create: (context) => TimeCounterBloc(
            service: RepositoryProvider.of<TimeCounterService>(context),
          ),
          child: HomePage(),
        ),
      ),
    );
  }
}
