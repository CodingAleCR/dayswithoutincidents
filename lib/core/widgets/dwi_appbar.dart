import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      tooltip: Resources.string(context, AppStrings.titleSettings),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (routeContext) {
              return const SettingsPage();
            },
          ),
        );
      },
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
      tooltip: 'Add',
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
    return IconButton(
      key: const ValueKey('btn_remove_counter'),
      tooltip: 'Delete',
      onPressed: disabled
          ? null
          : () => context.read<CounterListCubit>().deleteCurrentCounter(),
      icon: const Icon(Icons.delete_outlined),
    );
  }
}
