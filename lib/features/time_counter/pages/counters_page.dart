import 'package:domain/domain.dart';
import 'package:dwi/core/widgets/dwi_appbar.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:dwi/features/time_counter/cubit/counter_list_cubit.dart';
import 'package:dwi/features/time_counter/widgets/counter_list.dart';
import 'package:dwi/features/time_counter/widgets/counter_slider.dart';
import 'package:dwi/features/time_counter/widgets/empty_counters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [CountersPage]
class CountersPage extends StatelessWidget {
  /// [CountersPage] widget.
  ///
  /// Opens up after splash page.
  const CountersPage({super.key});

  /// Convenience route instatiaton.
  static Route<void> route() => PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BlocProvider<CounterListCubit>(
          create: (provCtx) => CounterListCubit(
            provCtx.read<ThemeChooserCubit>(),
            provCtx.read<TimeCounterService>(),
            provCtx.read<PreferencesService>(),
          )..fetchCounters(),
          child: const CountersPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeIn;

          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return FadeTransition(
            opacity: animation.drive(tween),
            child: child,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: DWIAppBar(),
      body: SafeArea(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final status = context.watch<CounterListCubit>().state.status;
    late final Widget child;

    switch (status) {
      case OperationStatus.idle:
      case OperationStatus.success:
        child = const _Counters();

      case OperationStatus.loading:
        child = const _Loading();

      case OperationStatus.failure:
        child = const _Error();
    }

    return child;
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).countersError),
    );
  }
}

class _Counters extends StatefulWidget {
  const _Counters();

  @override
  State<_Counters> createState() => _CountersState();
}

class _CountersState extends State<_Counters> {
  @override
  Widget build(BuildContext context) {
    final counters = context.select(
      (CounterListCubit cubit) => cubit.state.counters,
    );
    final selectedIdx = context.select(
      (CounterListCubit cubit) => cubit.state.selectedIdx,
    );
    final preferredMode = context.select(
      (CounterListCubit cubit) => cubit.state.preferredMode,
    );

    final currentTheme = context.read<ThemeChooserCubit>().state.theme;

    if (selectedIdx != -1 && currentTheme != counters[selectedIdx].theme) {
      context.read<ThemeChooserCubit>().themeChanged(
            counters[selectedIdx].theme,
          );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: counters.isEmpty
          ? const EmptyCounters()
          : preferredMode == DisplayModes.carousel
              ? CounterSlider(
                  counters: counters,
                  currentIndex: selectedIdx,
                )
              : CounterList(
                  counters: counters,
                ),
    );
  }
}
