import 'package:dwi/core/localization/app_localizations.dart';
import 'package:domain/domain.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

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
              child: BlocListener<TimeCounterBloc, TimeCounterState>(
                listener: (context, state) {
                  if (state is TimeCounterError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<TimeCounterBloc, TimeCounterState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case TimeCounterLoading:
                        return _Loading();
                      case TimeCounterLoaded:
                        return _Counter(
                          counter: (state as TimeCounterLoaded).counter,
                        );
                      default:
                        return _Counter(counter: TimeCounter.empty());
                    }
                  },
                ),
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
    final days = DateTime.now().difference(counter.incident!).inDays;
    String dayString = days != 1
        ? Resources.string(context, AppStrings.DAYS)
        : Resources.string(context, AppStrings.DAY);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          counter.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
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
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 125, fontWeight: FontWeight.normal),
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
        _ResetButton(),
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
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(
        Resources.string(context, AppStrings.BTN_RESET).toUpperCase(),
      ),
      onPressed: () {
        BlocProvider.of<TimeCounterBloc>(context).add(ResetTimeCounter());
      },
    );
  }
}
