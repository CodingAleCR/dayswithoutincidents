import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:dwi/core/application/application.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }

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
        ],
        child: const DWIApplication(),
      ),
    ),
  );
}
