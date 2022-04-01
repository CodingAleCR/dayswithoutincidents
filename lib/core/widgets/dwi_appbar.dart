import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DWIAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DWIAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        actions: [
          _AddCounterButton(),
          _DeleteCounterButton(),
          _AboutButton(),
        ],
      ),
      preferredSize: preferredSize,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AboutButton extends StatelessWidget {
  const _AboutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: Resources.string(context, AppStrings.TITLE_SETTINGS),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (routeContext) {
              return BlocProvider.value(
                value: BlocProvider.of<TimeCounterCubit>(context),
                child: SettingsPage(),
              );
            },
          ),
        );
      },
      icon: Icon(Icons.help_outline_rounded),
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
      key: ValueKey("btn_add_counter"),
      tooltip: "Add",
      onPressed: () => context.read<CounterListCubit>().addNewCounter(),
      icon: Icon(Icons.add),
    );
  }
}

class _DeleteCounterButton extends StatelessWidget {
  const _DeleteCounterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: ValueKey("btn_remove_counter"),
      tooltip: "Delete",
      onPressed: () => context.read<CounterListCubit>().deleteCurrentCounter(),
      icon: Icon(Icons.delete_outlined),
    );
  }
}
