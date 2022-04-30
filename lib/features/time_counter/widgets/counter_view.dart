import 'package:domain/domain.dart';
import 'package:dwi/core/extensions/date.extensions.dart';
import 'package:dwi/core/localization/app_localizations.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/features/theme_chooser/theme_chooser.dart';
import 'package:dwi/features/time_counter/time_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

/// CounterView
class CounterView extends StatelessWidget {
  /// Displays a counter's information
  const CounterView({
    Key? key,
    required this.counter,
  }) : super(key: key);

  /// Counter to be displayed
  final TimeCounter counter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: BlocProvider<TimeCounterCubit>(
          create: (context) => TimeCounterCubit(
            counter,
            RepositoryProvider.of<TimeCounterService>(context),
            RepositoryProvider.of<CounterRestartService>(context),
          )..fetchCounter(),
          child: const _Counter(),
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  const _Counter({
    Key? key,
  }) : super(key: key);

  Future<void> _titleInputDialog(BuildContext context) async {
    final counter = context.read<TimeCounterCubit>().state.counter;
    String? newTitle;
    final controller = TextEditingController(text: counter.title);
    await showDialog<String>(
      context: context,
      builder: (BuildContext bContext) {
        return AlertDialog(
          title: Text(
            Resources.string(bContext, AppStrings.inputTitle),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: Resources.string(
                bContext,
                AppStrings.preferenceTitle,
              ),
              hintText: Resources.string(
                bContext,
                AppStrings.hintTitle,
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                newTitle = Resources.string(
                  bContext,
                  AppStrings.daysWithoutIncidents,
                );
              } else {
                newTitle = value;
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text(MaterialLocalizations.of(bContext).cancelButtonLabel),
              onPressed: () {
                Navigator.of(bContext).pop(newTitle);
              },
            ),
            TextButton(
              child: Text(MaterialLocalizations.of(bContext).okButtonLabel),
              onPressed: () async {
                if (newTitle != null && newTitle!.isNotEmpty) {
                  final navigator = Navigator.of(bContext);

                  await context
                      .read<TimeCounterCubit>()
                      .titleChanged(newTitle!);

                  navigator.pop(newTitle);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _lastIncidentPicker(BuildContext context) async {
    final timeCounterCubit = context.read<TimeCounterCubit>();
    final counter = timeCounterCubit.state.counter;
    final today = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: counter.createdAt!,
      firstDate: DateTime(today.year - 80),
      lastDate: today,
    );

    if (selectedDate != null) {
      await timeCounterCubit.dateChanged(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<TimeCounterCubit>().state.counter;
    final themeName = counter.theme.displayName;
    final restarts = context.watch<TimeCounterCubit>().state.restarts.length;
    final longestStreak = context.watch<TimeCounterCubit>().state.longestStreak;
    final isLongestStreakAlive =
        context.watch<TimeCounterCubit>().state.isLongestStreakAlive;
    final longestStreakDayString = longestStreak != 1
        ? Resources.string(context, AppStrings.days)
        : Resources.string(context, AppStrings.day);

    final days = DateTime.now().difference(counter.createdAt!).inDays;
    final dayString = days != 1
        ? Resources.string(context, AppStrings.days)
        : Resources.string(context, AppStrings.day);
    return BlocListener<TimeCounterCubit, TimeCounterState>(
      listenWhen: (previous, current) =>
          previous.counter.theme != current.counter.theme,
      listener: (context, state) {
        context.read<ThemeChooserCubit>().themeChanged(state.counter.theme);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: InkWell(
              key: ValueKey(counter.title),
              borderRadius: BorderRadius.circular(8),
              onTap: () => _titleInputDialog(context),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  counter.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              '${days.toString()} $dayString',
              key: ValueKey(days),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLongestStreakAlive) ...[
                  const Icon(
                    FeatherIcons.zap,
                    size: 16,
                  ),
                  const SizedBox(width: 6)
                ],
                Text(
                  'Current Streak',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 4 / 3,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StatsCard(
                FeatherIcons.zap,
                title: 'Longest Streak',
                stat: '${longestStreak.toString()} $longestStreakDayString',
              ),
              StatsCard(
                Icons.cached_rounded,
                title: 'Times Restarted',
                stat: restarts.toString(),
              ),
              StatsCard(
                FeatherIcons.calendar,
                onTap: () => _lastIncidentPicker(context),
                title: 'Last Restart',
                stat: counter.createdAt!.toFormattedString('dd MMM yyyy'),
              ),
              StatsCard(
                Icons.palette_outlined,
                onTap: () => context.read<TimeCounterCubit>().themeChanged(
                      context.read<ThemeChooserCubit>().nextTheme(),
                    ),
                title: 'Theme',
                stat: themeName,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _ResetButton(
            counterId: counter.id,
          ),
        ],
      ),
    );
  }
}

/// StatsCard
class StatsCard extends StatelessWidget {
  /// Provides information about a stat.
  ///
  /// It has preconfigured styles and tap handlers.
  const StatsCard(
    this.iconData, {
    Key? key,
    required this.title,
    required this.stat,
    this.onTap,
  }) : super(key: key);

  /// Icon to be displayed
  final IconData iconData;

  /// Label of the stat displayed
  final String title;

  /// Value of the stat displayed
  final String stat;

  /// On tap handler for the card
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor:
          Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.15),
      onTap: onTap,
      child: Container(
        color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.15),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 14,
                  left: 14,
                  right: 8,
                ),
                child: Icon(
                  iconData,
                  size: 18,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  stat,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.16,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({
    Key? key,
    required this.counterId,
  }) : super(key: key);

  final String counterId;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        Resources.string(context, AppStrings.btnReset).toUpperCase(),
      ),
      onPressed: () => context.read<TimeCounterCubit>().restartCounter(),
    );
  }
}

// ignore: unused_element
class _EditCounterButton extends StatelessWidget {
  const _EditCounterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: Resources.string(context, AppStrings.labelCustomization),
      onPressed: () async {
        await showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 16,
              ),
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                color: DWIColors.brandWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: <Widget>[
                  const Text(
                    'Modal BottomSheet',
                    style: TextStyle(
                      color: DWIColors.brandBlue,
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Close'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
