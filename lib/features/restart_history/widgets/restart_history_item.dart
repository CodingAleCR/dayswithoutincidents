import 'package:domain/domain.dart';
import 'package:dwi/core/extensions/date.extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// RestartHistoryItem
class RestartHistoryItem extends StatelessWidget {
  /// RestartHistoryItem
  ///
  /// Displays a restart item as a ListTile, with the streak count as title
  /// and the date of start and restart as subtitle.
  const RestartHistoryItem({
    Key? key,
    required this.restart,
  }) : super(key: key);

  /// Restart of a counter.
  final CounterRestart restart;

  @override
  Widget build(BuildContext context) {
    final startingDay = restart.startedAt?.toFormattedString('MMM d, yyyy');
    final restartingDay = restart.restartedAt?.toFormattedString('MMM d, yyyy');
    var subtitle = '$startingDay '
        '-> $restartingDay';

    if (restart.startedAt?.isSameDay(restart.restartedAt) == true) {
      final startingHour = restart.startedAt?.toFormattedString('jm');
      final restartingHour = restart.restartedAt?.toFormattedString('jm');

      subtitle = '$startingDay. $startingHour '
          '-> $restartingHour';
    }

    final days = restart.streak;

    return ListTile(
      title: Text(
        AppLocalizations.of(context)!.dayCount(days),
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
