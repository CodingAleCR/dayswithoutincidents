import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:dwi/core/application/application.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {},
    appRunner: () => runApp(
      Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        dispose: (context, value) => value.close(),
        child: const AppWithDatabase(),
      ),
    ),
  );
}

class AppWithDatabase extends StatelessWidget {
  const AppWithDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TimeCounterService>(
          create: (context) => TimeCounterServiceImpl(
            database: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<CounterRestartService>(
          create: (context) => CounterRestartServiceImpl(
            database: context.read<AppDatabase>(),
          ),
        ),
        RepositoryProvider<PreferencesService>(
          create: (context) => PreferencesServiceImpl(),
        ),
      ],
      child: const DWIApplication(),
    );
  }
}
