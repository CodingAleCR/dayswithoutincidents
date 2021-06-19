import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/features/time_counter/pages/settings_page.dart';
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
              child: TextButton(
                child: Text(
                  Resources.string(context, AppStrings.LABEL_CUSTOMIZATION),
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
        ],
      ),
    );
  }
}
