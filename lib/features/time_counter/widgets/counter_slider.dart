import 'package:domain/domain.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:dwi/features/time_counter/time_counter.dart';
import 'package:dwi/features/time_counter/widgets/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [CounterSlider]
class CounterSlider extends StatefulWidget {
  /// Displays a list of counters in a page view format.
  const CounterSlider({
    required this.counters,
    super.key,
    this.currentIndex = 0,
  });

  /// Current index selected.
  final int currentIndex;

  /// List of counters to be displayed.
  final List<TimeCounter> counters;

  @override
  State<CounterSlider> createState() => _CounterSliderState();
}

class _CounterSliderState extends State<CounterSlider>
    with TickerProviderStateMixin {
  late List<TimeCounter> counters;
  late PageController pageController;
  late TabController controller;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: widget.currentIndex,
    );
    configureControllers();
  }

  void configureControllers() {
    counters = widget.counters;

    controller = TabController(
      initialIndex: widget.currentIndex,
      length: widget.counters.length,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(covariant CounterSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.counters != widget.counters) {
      controller.dispose();
      configureControllers();
    }

    if (oldWidget.currentIndex != widget.currentIndex ||
        oldWidget.counters != widget.counters) {
      pageController.animateToPage(
        widget.currentIndex,
        duration: const Duration(milliseconds: 150),
        curve: Curves.ease,
      );
      controller.animateTo(widget.currentIndex);
      context.read<ThemeChooserCubit>().themeChanged(
            counters[widget.currentIndex].theme,
          );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: PageView(
            controller: pageController,
            children: widget.counters
                .map(
                  (e) => Center(
                    key: ValueKey(e.id),
                    child: CounterView(
                      counter: e,
                    ),
                  ),
                )
                .toList(),
            onPageChanged: (selectedIdx) => context
                .read<CounterListCubit>()
                .selectedCounterChanged(selectedIdx),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TabPageSelector(
              controller: controller,
              selectedColor: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}
