import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = context.read<TimeCounterCubit>();
    final counter = cubit.state.counter;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dContext) => Dialog(
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
                      FeatherIcons.trash,
                      size: 32,
                      color: DWIColors.brandBlueTint1,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Do you want to delete the counter "${counter.title}"?',
                  style: Theme.of(dContext)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
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
                    child: Text(S.of(context).btnDelete),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    if (context.mounted && (confirmed ?? false)) {
      await context.read<TimeCounterCubit>().deleteCounter();
    }
  }

  @override
  Widget build(BuildContext context) {
    final disabled = context.watch<CounterListCubit>().state.counters.isEmpty;
    return IconButton(
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      onPressed: disabled ? null : () => _confirmDelete(context),
      icon: const Icon(
        Icons.delete_outlined,
        size: 24,
      ),
      key: const ValueKey('btn_remove_counter'),
      tooltip: S.of(context).btnDelete,
    );
  }
}
