import 'package:domain/domain.dart';
import 'package:dwi/features/time_counter/cubit/time_counter_cubit.dart';
import 'package:dwi/features/time_counter/widgets/counter_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [CounterList]
class CounterList extends StatelessWidget {
  /// Displays a list of counters in a list view format.
  const CounterList({
    required this.counters,
    super.key,
  });

  /// List of counters to be displayed.
  final List<TimeCounter> counters;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (iCont, idx) {
        return BlocProvider<TimeCounterCubit>(
          create: (context) => TimeCounterCubit(
            counters[idx],
            RepositoryProvider.of<TimeCounterService>(context),
            RepositoryProvider.of<CounterRestartService>(context),
          )..fetchCounter(),
          child: const CounterListItem(),
        );
      },
      separatorBuilder: (sCont, idx) => const Divider(
        thickness: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemCount: counters.length,
    );
  }
}
