import 'package:dwi/features/time_counter/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dwi/core/localization/localization.dart';

import '../bloc/bloc.dart';
import '../widgets/default_counter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TimeCounterBloc>(context)..add(GetTimeCounter());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 8,
            right: 8,
            child: SafeArea(
              child: FlatButton(
                child: Text(
                  AppLocalizations.of(context)
                      .translate(AppStrings.LABEL_CUSTOMIZATION),
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (routeContext) {
                        return BlocProvider.value(
                          value: BlocProvider.of<TimeCounterBloc>(context),
                          child: SettingsPage(),
                        );
                      },
                    ),
                  );
                  BlocProvider.of<TimeCounterBloc>(context)
                    ..add(GetTimeCounter());
                },
              ),
            ),
          ),
          DefaultCounter(),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Text(
                  AppLocalizations.of(context)
                      .translate(AppStrings.HOME_CREDITS),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
