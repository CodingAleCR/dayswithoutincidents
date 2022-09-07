import 'package:domain/domain.dart';
import 'package:dwi/core/widgets/widgets.dart';
import 'package:dwi/features/streaks_history/cubit/streaks_cubit.dart';
import 'package:dwi/features/streaks_history/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Streaks page, displays a chart with different streaks
/// and a list of streaks.
class StreaksPage extends StatelessWidget {
  /// Streaks page, displays a chart with different streaks
  /// and a list of streaks.
  const StreaksPage({Key? key}) : super(key: key);

  /// Convenience route instatiaton.
  static MaterialPageRoute<void> route(TimeCounter counter) =>
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (c) => StreaksCubit(
            c.read<CounterRestartService>(),
            counter: counter,
          )..fetchRestarts(),
          child: const StreaksPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final restarts = context.watch<StreaksCubit>().state.restarts;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.streaksPageTitle),
        centerTitle: true,
      ),
      body: restarts.isNotEmpty
          ? const _Content()
          : ListEmptyState(
              title: AppLocalizations.of(context)!.streaksEmptyTitle,
              subtitle: AppLocalizations.of(context)!.streaksEmptyMsg,
            ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            AppLocalizations.of(context)!.streaksChartTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const StreaksChart(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            AppLocalizations.of(context)!.streaksTopListTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const StreaksList(),
      ],
    );
  }
}
