import 'package:duration/duration.dart';
import 'package:dwi/core/extensions/extensions.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [ResetButton]
class ResetButton extends StatelessWidget {
  /// Button to reset the counter in context of TimeCounterCubit
  const ResetButton({
    super.key,
  });

  Future<void> _confirmRestart(BuildContext context) async {
    final cubit = context.read<TimeCounterCubit>();
    final counter = cubit.state.counter;
    final currentStreak = cubit.state.currentStreak;
    final streakLabel = prettyDuration(
      currentStreak,
      tersity: DurationTersity.minute,
      delimiter: ', ',
      locale: context.durationLocale,
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeData =
        isDark ? DarkSideTheme().themeData : PlainLightTheme().themeData;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dContext) => Theme(
        data: themeData,
        child: Builder(
          builder: (nContext) {
            return Dialog(
              shape: const ContinuousRectangleBorder(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    shrinkWrap: true,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundColor: DWIColors.brandCyan,
                          radius: 32,
                          child: Icon(
                            FeatherIcons.refreshCw,
                            size: 32,
                            color: DWIColors.brandBlueTint1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        S.of(context).restartDialogTitle,
                        style: Theme.of(nContext)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: S.of(context).restartDialogContentLn1,
                            ),
                            TextSpan(
                              text: counter.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: S.of(context).restartDialogContentLn2,
                            ),
                            TextSpan(
                              text: streakLabel,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: S.of(context).restartDialogContentLn3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dContext, false),
                          style: OutlinedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            MaterialLocalizations.of(context).cancelButtonLabel,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(dContext, true),
                          style: ElevatedButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(S.of(context).btnReset),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    if (confirmed ?? false) {
      await cubit.restartCounter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () => _confirmRestart(context),
      child: Text(
        S.of(context).btnReset.toUpperCase(),
      ),
    );
  }
}
