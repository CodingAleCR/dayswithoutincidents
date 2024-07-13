import 'package:dwi/features/features.dart';
import 'package:dwi/features/time_counter/widgets/counter_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<TimeCounterCubit>().state.counter;

    return ElevatedButton(
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        constraints: const BoxConstraints.expand(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        builder: (sheetContext) => CounterForm(
          title: counter.title,
          lastRestart: counter.createdAt!,
          onSubmit: (title, lastRestart) {
            context.read<TimeCounterCubit>().counterChanged(title, lastRestart);
          },
        ),
      ),
      child: Text(S.of(context).btnEdit),
    );
  }
}
