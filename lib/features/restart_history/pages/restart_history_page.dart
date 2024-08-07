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
  const RestartHistoryPage({super.key});

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
        title: Text(S.of(context).restartsPageTitle),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (range == null || !context.mounted) return;

              await context.read<RestartsCubit>().addRestart(
                    from: range.start,
                    to: range.end,
                  );
            },
            child: Text(S.of(context).addRestartBtn),
          ),
        ],
      ),
      body: restarts.isNotEmpty
          ? RestartHistoryList(
              restarts: restarts,
            )
          : ListEmptyState(
              title: S.of(context).restartsEmptyTitle,
              subtitle: S.of(context).restartsEmptyMsg,
            ),
    );
  }
}
