import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/features/time_counter/time_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [EmptyCounters]
class EmptyCounters extends StatelessWidget {
  /// Displays an empty state view for adding a new counter easily when
  /// there's no counters in storage.
  const EmptyCounters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Resources.asset(context, 'empty_counters'),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No incidents?',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'You are not tracking anything yet. Add a new counter!',
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: Text(
              'Add Counter'.toUpperCase(),
            ),
            onPressed: () => context.read<CounterListCubit>().addNewCounter(),
          ),
        ],
      ),
    );
  }
}
