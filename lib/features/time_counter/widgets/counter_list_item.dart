import 'package:dwi/core/extensions/date.extensions.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/core/utils/counter_utils.dart';
import 'package:dwi/features/features.dart';
import 'package:dwi/features/time_counter/widgets/delete_button.dart';
import 'package:dwi/features/time_counter/widgets/edit_icon_button.dart';
import 'package:dwi/features/time_counter/widgets/restart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

enum DisplayPage {
  detail,
  stats,
}

/// [CounterListItem]
class CounterListItem extends StatefulWidget {
  /// Displays a counter item in a list view format.
  const CounterListItem({
    super.key,
  });

  @override
  State<CounterListItem> createState() => _CounterListItemState();
}

class _CounterListItemState extends State<CounterListItem> {
  DisplayPage _currentPage = DisplayPage.detail;

  @override
  Widget build(BuildContext context) {
    final restarts = context.watch<TimeCounterCubit>().state.restarts;
    final counter = context.watch<TimeCounterCubit>().state.counter;
    final longestStreak = context.watch<TimeCounterCubit>().state.longestStreak;
    final daysDiff = DateTime.now().difference(counter.createdAt!);
    final counterTheme = Theme.of(context).extension<BrandedTheme>()!;
    final isLongestStreakAlive =
        context.watch<TimeCounterCubit>().state.isLongestStreakAlive;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        color: counterTheme.accentColor,
        shape: const ContinuousRectangleBorder(),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: _currentPage == DisplayPage.detail
              ? Column(
                  key: const ValueKey('detail'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              counter.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const Gap(8),
                          const EditIconButton(),
                          const DeleteButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                timeCounterHourCount(context, daysDiff),
                                key: ValueKey(daysDiff),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
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
                                      const SizedBox(width: 4),
                                    ],
                                    Text(
                                      S.of(context).counterDetailCurrentStreak,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _currentPage = DisplayPage.stats;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('STATS'),
                          ),
                        ),
                        const Expanded(
                          child: ResetButton(),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  key: const ValueKey('stats'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        TextButton.icon(
                          label: const Text('Back'),
                          onPressed: () => setState(() {
                            _currentPage = DisplayPage.detail;
                          }),
                          icon: const Icon(Icons.chevron_left),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(FeatherIcons.zap),
                          const SizedBox(width: 8),
                          Text(
                            '${S.of(context).counterDetailLongestStreak}:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            timeCounterHourCount(context, longestStreak),
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(FeatherIcons.rotateCcw),
                          const SizedBox(width: 8),
                          Text(
                            '${S.of(context).counterDetailTimesRestarted}:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            restarts.length.toString(),
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(FeatherIcons.calendar),
                          const SizedBox(width: 8),
                          Text(
                            '${S.of(context).counterDetailLastRestart}:',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            counter.createdAt!.toFormattedString('dd MMM yyyy'),
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.of(context).push(
                                StreaksPage.route(counter),
                              ),
                              style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('View Streaks'),
                            ),
                          ),
                          const VerticalDivider(
                            thickness: 1,
                            indent: 8,
                            endIndent: 8,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.of(context).push(
                                RestartHistoryPage.route(counter),
                              ),
                              style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('View Restarts'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
