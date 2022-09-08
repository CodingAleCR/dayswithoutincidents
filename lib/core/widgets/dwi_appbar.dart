import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// DWIAppBar
class DWIAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom app bar implementation for DWI.
  ///
  /// Contains actions for adding a new counter, deleting current counter
  /// or opening the about informating page.
  const DWIAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        actions: const [
          _AddCounterButton(),
          _DeleteCounterButton(),
          _AboutButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AboutButton extends StatelessWidget {
  const _AboutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: S.of(context).titleActivitySettings,
      onPressed: () => Navigator.of(context).push(SettingsPage.route()),
      icon: const Icon(Icons.help_outline_rounded),
    );
  }
}

class _AddCounterButton extends StatelessWidget {
  const _AddCounterButton({
    Key? key,
  }) : super(key: key);

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
  const _DeleteCounterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disabled = context.watch<CounterListCubit>().state.counters.isEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: disabled ? 0 : 48,
      child: ClipRect(
        child: IconButton(
          onPressed: disabled
              ? null
              : () => context.read<CounterListCubit>().deleteCurrentCounter(),
          icon: const Icon(Icons.delete_outlined),
          key: const ValueKey('btn_remove_counter'),
          tooltip: S.of(context).btnDelete,
        ),
      ),
    );
  }
}
