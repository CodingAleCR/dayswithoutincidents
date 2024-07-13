import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:dwi/core/application/application.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {},
    appRunner: () => runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<TimeCounterService>(
            create: (context) => TimeCounterServiceImpl(),
          ),
          RepositoryProvider<CounterRestartService>(
            create: (context) => CounterRestartServiceImpl(),
          ),
          RepositoryProvider<PreferencesService>(
            create: (context) => PreferencesServiceImpl(),
          ),
        ],
        child: const DWIApplication(),
      ),
    ),
  );
}
