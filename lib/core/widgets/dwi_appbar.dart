import 'package:domain/domain.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// DWIAppBar
class DWIAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom app bar implementation for DWI.
  ///
  /// Contains actions for adding a new counter, deleting current counter
  /// or opening the about informating page.
  const DWIAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<CounterListCubit>().state.preferredMode;
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        title: mode.isList ? Text(S.of(context).listViewTitle) : null,
        actions: [
          if (mode.isList) const _ToggleThemeButton(),
          const _AddCounterButton(),
          if (mode.isCarousel) const _DeleteCounterButton(),
          const _AboutButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AboutButton extends StatelessWidget {
  const _AboutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).titleActivitySettings,
      onPressed: () async {
        final counterCubit = context.read<CounterListCubit>();

        await Navigator.of(context).push(SettingsPage.route());
        await counterCubit.reloadDisplayMode();
      },
      icon: const Icon(Icons.settings_outlined),
    );
  }
}

class _ToggleThemeButton extends StatelessWidget {
  const _ToggleThemeButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('btn_toggle_theme'),
      tooltip: S.of(context).themeCustomization,
      onPressed: () {
        context.read<ThemeChooserCubit>().nextDefaultTheme();
      },
      icon: const Icon(Icons.palette_outlined),
    );
  }
}

class _AddCounterButton extends StatelessWidget {
  const _AddCounterButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('btn_add_counter'),
      tooltip: S.of(context).btnAdd,
      onPressed: () => context.read<CounterListCubit>().addNewCounter(),
      icon: const Icon(Icons.add),
    );
  }
}

class _DeleteCounterButton extends StatelessWidget {
  const _DeleteCounterButton();

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = context.read<CounterListCubit>();
    final counter = cubit.state.selected;

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
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.3),
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
      await context.read<CounterListCubit>().deleteCurrentCounter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const ValueKey('btn_delete_counter'),
      tooltip: S.of(context).btnDelete,
      onPressed: () => _confirmDelete(context),
      icon: const Icon(
        FeatherIcons.trash,
        size: 24,
      ),
    );
  }
}
