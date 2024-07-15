import 'package:domain/domain.dart';
import 'package:dwi/core/extensions/date.extensions.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/core/utils/counter_utils.dart';
import 'package:dwi/core/utils/date_picker_utils.dart';
import 'package:dwi/features/features.dart';
import 'package:dwi/features/time_counter/widgets/edit_button.dart';
import 'package:dwi/features/time_counter/widgets/restart_button.dart';
import 'package:dwi/features/time_counter/widgets/stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// CounterView
class CounterView extends StatelessWidget {
  /// Displays a counter's information
  const CounterView({
    required this.counter,
    super.key,
  });

  /// Counter to be displayed
  final TimeCounter counter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeCounterCubit>(
      create: (context) => TimeCounterCubit(
        counter,
        RepositoryProvider.of<TimeCounterService>(context),
        RepositoryProvider.of<CounterRestartService>(context),
      )..fetchCounter(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const _Counter(),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter();

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<TimeCounterCubit>().state.counter;
    final counterTheme = DWIThemes.getTheme(counter.theme).brandedTheme;
    final themeName = counter.theme.displayName;
    final restarts = context.watch<TimeCounterCubit>().state.restarts.length;
    final longestStreak = context.watch<TimeCounterCubit>().state.longestStreak;
    final isLongestStreakAlive =
        context.watch<TimeCounterCubit>().state.isLongestStreakAlive;

    final daysDiff = DateTime.now().difference(counter.createdAt!);
    return BlocListener<TimeCounterCubit, TimeCounterState>(
      listenWhen: (previous, current) =>
          previous.counter.theme != current.counter.theme,
      listener: (context, state) {
        context.read<ThemeChooserCubit>().themeChanged(state.counter.theme);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                counter.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              timeCounterHourCount(context, daysDiff),
              key: ValueKey(daysDiff),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLongestStreakAlive) ...[
                  const Icon(
                    FeatherIcons.zap,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  S.of(context).counterDetailCurrentStreak,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 4 / 3,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StatsCard(
                FeatherIcons.zap,
                onTap: () => Navigator.of(context).push(
                  StreaksPage.route(counter),
                ),
                title: S.of(context).counterDetailLongestStreak,
                stat: timeCounterHourCount(context, longestStreak),
                color: counterTheme.accentColor,
              ),
              StatsCard(
                Icons.cached_rounded,
                onTap: () => Navigator.of(context).push(
                  RestartHistoryPage.route(counter),
                ),
                title: S.of(context).counterDetailTimesRestarted,
                stat: restarts.toString(),
                color: counterTheme.accentColor,
              ),
              StatsCard(
                FeatherIcons.calendar,
                onTap: () async {
                  final updatedRestart = await showDateTimePicker(
                    context,
                    initialDate: DateTime.now(),
                    currentDate: counter.createdAt!,
                  );

                  if (updatedRestart == null || !context.mounted) return;

                  context.read<TimeCounterCubit>().dateChanged(updatedRestart);
                },
                title: S.of(context).counterDetailLastRestart,
                stat: counter.createdAt!.toFormattedString('dd MMM yyyy'),
                color: counterTheme.accentColor,
              ),
              StatsCard(
                Icons.palette_outlined,
                onTap: () => context.read<TimeCounterCubit>().themeChanged(
                      context
                          .read<ThemeChooserCubit>()
                          .nextTheme(counter.theme),
                    ),
                title: S
                    .of(
                      context,
                    )
                    .counterDetailTheme,
                stat: themeName,
                color: counterTheme.accentColor,
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: EditButton()),
              SizedBox(width: 8),
              Expanded(child: ResetButton()),
            ],
          ),
        ],
      ),
    );
  }
}
