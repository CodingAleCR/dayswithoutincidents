import 'package:dwi/features/time_counter/data/data.dart';
import 'package:dwi/features/time_counter/domain/domain.dart';
import 'package:dwi/features/time_counter/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../localization/localization.dart';

class DWIApplication extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Days Without Incidents',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
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
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: RepositoryProvider<TimeCounterRepository>(
        builder: (context) => TimeCounterRepositoryImpl(),
        child: BlocProvider<TimeCounterBloc>(
          builder: (context) => TimeCounterBloc(
            repository: RepositoryProvider.of<TimeCounterRepository>(context),
          ),
          child: HomePage(),
        ),
      ),
    );
  }
}
