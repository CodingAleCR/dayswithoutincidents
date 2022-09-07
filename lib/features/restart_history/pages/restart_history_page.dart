import 'package:domain/domain.dart';
import 'package:dwi/core/widgets/widgets.dart';
import 'package:dwi/features/restart_history/cubit/restarts_cubit.dart';
import 'package:dwi/features/restart_history/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// RestartHistory page, displays a chart with different streaks
/// and a list of streaks.
class RestartHistoryPage extends StatelessWidget {
  /// RestartHistory page, displays a chart with different streaks
  /// and a list of streaks.
  const RestartHistoryPage({Key? key}) : super(key: key);

  /// Convenience route instatiaton.
  static MaterialPageRoute<void> route(TimeCounter counter) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (c) => RestartsCubit(
            c.read<CounterRestartService>(),
            counter: counter,
          )..fetchRestarts(),
          child: const RestartHistoryPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final restarts = context.watch<RestartsCubit>().state.restarts;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.restartsPageTitle),
        centerTitle: true,
      ),
      body: restarts.isNotEmpty
          ? RestartHistoryList(
              restarts: restarts,
            )
          : ListEmptyState(
              title: AppLocalizations.of(context)!.restartsEmptyTitle,
              subtitle: AppLocalizations.of(context)!.restartsEmptyMsg,
            ),
    );
  }
}
