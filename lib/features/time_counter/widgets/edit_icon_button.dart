import 'package:dwi/features/features.dart';
import 'package:dwi/features/time_counter/widgets/counter_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditIconButton extends StatelessWidget {
  const EditIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<TimeCounterCubit>().state.counter;

    return IconButton(
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
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      icon: const Icon(Icons.edit_outlined),
    );
  }
}
