import 'package:domain/domain.dart';
import 'package:dwi/core/widgets/dwi_appbar.dart';
import 'package:dwi/features/time_counter/cubit/counter_list_cubit.dart';
import 'package:dwi/features/time_counter/widgets/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DWIAppBar(),
      body: SafeArea(child: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.watch<CounterListCubit>().state.status;

    switch (status) {
      case OperationStatus.idle:
      case OperationStatus.success:
        return _CounterList();

      case OperationStatus.loading:
        return _Loading();

      case OperationStatus.failure:
        return _Error();
    }
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Could not load your time counters.'),
    );
  }
}

class _CounterList extends StatefulWidget {
  const _CounterList({
    Key? key,
  }) : super(key: key);

  @override
  State<_CounterList> createState() => _CounterListState();
}

class _CounterListState extends State<_CounterList>
    with TickerProviderStateMixin {
  final pageController = PageController();
  TabController? controller;

  @override
  Widget build(BuildContext context) {
    final counters = context.watch<CounterListCubit>().state.counters;
    final selectedIdx = context.watch<CounterListCubit>().state.selectedIdx;

    controller = TabController(
      initialIndex: selectedIdx,
      length: counters.length,
      vsync: this,
    );
    return BlocListener<CounterListCubit, CounterListState>(
      listenWhen: (previous, current) =>
          previous.selectedIdx != current.selectedIdx,
      listener: (context, state) {
        if (state.selectedIdx != selectedIdx) {
          pageController.animateToPage(
            state.selectedIdx,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: counters
                  .map((e) => CounterView(
                        counter: e,
                      ))
                  .toList(),
              onPageChanged: (selectedIdx) => context
                  .read<CounterListCubit>()
                  .selectedCounterChanged(selectedIdx),
            ),
          ),
          TabPageSelector(
            controller: controller,
            selectedColor: Theme.of(context).textTheme.bodyText1?.color,
          ),
        ],
      ),
    );
  }
}
