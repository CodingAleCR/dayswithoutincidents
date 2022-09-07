import 'package:dwi/core/extensions/date.extensions.dart';
import 'package:dwi/features/streaks_history/cubit/streaks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Displays a list of streaks as tiles inside a [ListView]
class StreaksList extends StatelessWidget {
  /// Displays a list of streaks as tiles inside a [ListView]
  const StreaksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restarts = context.watch<StreaksCubit>().state.topTenStreaks;

    return ListView.separated(
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Divider(),
      ),
      itemBuilder: (context, index) {
        final restart = restarts[index];
        final startingDay = restart.startedAt?.toFormattedString('MMM d, yyyy');
        final restartingDay =
            restart.restartedAt?.toFormattedString('MMM d, yyyy');
        var subtitle = '$startingDay '
            'to $restartingDay';

        if (restart.startedAt?.isSameDay(restart.restartedAt) == true) {
          final startingHour = restart.startedAt?.toFormattedString('jm');
          final restartingHour = restart.restartedAt?.toFormattedString('jm');

          subtitle = 'From $startingDay at $startingHour '
              'to $restartingHour';
        }

        final days = restart.streak;

        return ListTile(
          title: Text(
            AppLocalizations.of(context)!.dayCount(days),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      itemCount: restarts.length,
      shrinkWrap: true,
    );
  }
}
