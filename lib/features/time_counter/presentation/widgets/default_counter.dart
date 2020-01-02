import 'package:dwi/core/localization/app_localizations.dart';
import 'package:dwi/features/time_counter/domain/domain.dart';
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
      children: <Widget>[
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
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<TimeCounterBloc, TimeCounterState>(
                  builder: (context, state) {
                    if (state is TimeCounterLoading) {
                      return buildLoading();
                    } else if (state is TimeCounterLoaded) {
                      return buildTimeCounterInfo(state.counter);
                    } else {
                      return buildTimeCounterInfo(TimeCounter.empty());
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

  Widget buildTimeCounterInfo(TimeCounter counter) {
    final days = DateTime.now().difference(counter.incident).inDays;
    String dayString = days != 1
        ? AppLocalizations.of(context).translate(AppStrings.DAYS)
        : AppLocalizations.of(context).translate(AppStrings.DAY);
    String widgetString = "$days $dayString.";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          counter.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.display1,
        ),
        Container(
          height: 32,
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            child: Center(
              child: Text(
                widgetString,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.display3,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ResetButton(),
        )
      ],
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations labels = AppLocalizations.of(context);
    return FlatButton(
      textColor: Theme.of(context).errorColor,
      child: Text(
        labels.translate(AppStrings.BTN_RESET),
      ),
      onPressed: () {
        BlocProvider.of<TimeCounterBloc>(context).add(ResetTimeCounter());
      },
    );
  }
}
