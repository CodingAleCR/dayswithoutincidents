import 'package:domain/domain.dart';
import 'package:dwi/core/localization/app_localizations.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/core/theme/colors.dart';
import 'package:dwi/features/time_counter/cubit/time_counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultCounter extends StatefulWidget {
  @override
  _DefaultCounterState createState() => _DefaultCounterState();
}

class _DefaultCounterState extends State<DefaultCounter> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 16,
          bottom: 16,
          left: 16,
          right: 16,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(32),
              child: BlocBuilder<TimeCounterCubit, TimeCounterState>(
                builder: (context, state) {
                  switch (state.status) {
                    case OperationStatus.loading:
                      return _Loading();

                    default:
                      return _Counter(counter: state.counter);
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Counter extends StatelessWidget {
  final TimeCounter counter;

  const _Counter({
    Key? key,
    required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final days = DateTime.now().difference(counter.createdAt).inDays;
    String dayString = days != 1
        ? Resources.string(context, AppStrings.DAYS)
        : Resources.string(context, AppStrings.DAY);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Text(
            counter.title,
            key: ValueKey(counter.title),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Text(
            days.toString(),
            key: ValueKey(days),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 125,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        SizedBox(height: 24),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Text(
            dayString,
            key: ValueKey(dayString),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(height: 24),
        _ResetButton(
          counterId: counter.id,
        ),
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ResetButton extends StatelessWidget {
  final String counterId;

  const _ResetButton({Key? key, required this.counterId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        Resources.string(context, AppStrings.BTN_RESET).toUpperCase(),
      ),
      onPressed: () => context.read<TimeCounterCubit>().resetCounter(),
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
      icon: Icon(Icons.edit),
      tooltip: Resources.string(context, AppStrings.LABEL_CUSTOMIZATION),
      onPressed: () async {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 16,
              ),
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: DWIColors.brandWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Text(
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
