
import 'package:dwi/domain/bloc/bloc.dart';
import 'package:dwi/domain/models/day_counter.dart';
import 'package:dwi/ui/widgets/default_counter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Bloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Bloc();
    _bloc.init().then((instance) {
      instance.fetchCounter();
    });
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
                  "Customize",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () async {
                  await Navigator.pushNamed(context, "/settings");
                  _bloc.fetchCounter();
                },
              ),
            ),
          ),
          StreamBuilder<DayCounter>(
            stream: _bloc.counter,
            builder: (context, AsyncSnapshot<DayCounter> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final counter = snapshot.data;
              return DefaultCounter(
                title: counter.title,
                days: DateTime.now().difference(counter.incident).inDays,
                onReset: () {
                  _bloc.resetCounter();
                },
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Text(
                  "Made with ♥ from Costa Rica.",
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
