import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await PrefService.init(prefix: 'dwi_');
  runApp(DWIApplication());
}

class DWIApplication extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Days Without Incidents',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

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
                days: counter.days,
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

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Bloc _bloc;

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = Bloc();
    _bloc.init().then((instance) {
      instance.fetchCounter();
    });
  }

  _titleInputDialog() {
    String newTitle;
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder<DayCounter>(
          stream: _bloc.counter,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final counter = snapshot.data;
            final controller = TextEditingController(text: counter.title);

            return AlertDialog(
              title: Text('Enter the title'),
              content: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: 'eg. Days without incidents'),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          newTitle = "Days without incidents";
                        } else {
                          newTitle = value;
                        }
                      },
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(newTitle);
                  },
                ),
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    if (newTitle != null) {
                      _bloc.setTitle(newTitle);
                      Navigator.of(context).pop(newTitle);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<DayCounter>(
        stream: _bloc.counter,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final counter = snapshot.data;
          titleController.text = counter.title;

          return ListView(
            padding: EdgeInsets.only(top: 16, left: 32, right: 16),
            children: <Widget>[
              Text(
                "Customize",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text(
                  "Title",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "This is the title to be shown by the app.",
                  style: Theme.of(context).textTheme.caption,
                ),
                onTap: _titleInputDialog,
              ),
              Divider(),
              Text(
                "About",
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text(
                  "Version",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "2.0.0",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              ListTile(
                title: Text(
                  "Developed with Flutter",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                subtitle: Text(
                  "by CodingAleCR.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Bloc {
  DayCounterRepository _repository = DayCounterRepository();

  BehaviorSubject<DayCounter> _counter = BehaviorSubject<DayCounter>();
  Observable<DayCounter> get counter => _counter.stream;

  Future<Bloc> init() async {
    await _repository.init();

    return this;
  }

  Future<void> fetchCounter() async {
    DayCounter counter = await _repository.getDayCounter();
    if (counter == null) {
      _counter.add(DayCounter.EMPTY_COUNTER);
    } else {
      _counter.add(counter);
    }
  }

  void setTitle(String title) {
    DayCounter counter = _counter.value;
    if (counter != null) {
      counter = DayCounter(title, counter.days);
    } else {
      counter = DayCounter(title, 0);
    }
    _repository.setDayCounter(counter);
    _counter.add(counter);
  }

  void resetCounter() async {
    await _repository.resetCounter();
    await fetchCounter();
  }

  void dispose() {
    _repository.dispose();
    _counter.close();
  }
}

class DayCounter {
  final String title;
  final int days;

  DayCounter(this.title, this.days);

  static final DayCounter EMPTY_COUNTER = DayCounter(DEFAULT_TITLE, 0);
}

const String DEFAULT_TITLE = "Days without incidents";

abstract class DayCounterProvider {
  Future<void> init();
  void setCounter(DayCounter counter);
  DayCounter getCounter();
  void resetCounter();
  void dispose();
}

class DayCounterRepository {
  DayCounterProvider _counterProvider = DayCounterSharedPreferenceProvider();

  Future<void> init() async {
    await _counterProvider.init();
  }

  Future<DayCounter> getDayCounter() async {
    return _counterProvider.getCounter();
  }

  Future<void> setDayCounter(DayCounter counter) async {
    _counterProvider.setCounter(counter);
  }

  Future<void> resetCounter() async {
    _counterProvider.resetCounter();
  }

  void dispose() {
    _counterProvider.dispose();
  }
}

const String TITLE = "title";
const String LAST_INCIDENT = "last_incident";

class DayCounterSharedPreferenceProvider implements DayCounterProvider {
  SharedPreferences _prefs;
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  DayCounter getCounter() {
    if (_prefs.containsKey(TITLE) && _prefs.containsKey(LAST_INCIDENT)) {
      DateTime now = DateTime.now();
      String title = _prefs.getString(TITLE);
      String lastIncidentString = _prefs.getString(LAST_INCIDENT);
      DateTime lastIncident = DateTime.parse(lastIncidentString);

      return DayCounter(title, now.difference(lastIncident).inDays);
    } else {
      final counter = DayCounter.EMPTY_COUNTER;
      setCounter(counter);

      return counter;
    }
  }

  @override
  void setCounter(DayCounter counter) {
    _prefs.setString(TITLE, counter.title);
    _prefs.setString(LAST_INCIDENT,
        DateTime.now().add(Duration(days: -counter.days)).toIso8601String());
  }

  @override
  Future<void> resetCounter() async {
    final now = DateTime.now().toIso8601String();
    print(now);
    _prefs.setString(LAST_INCIDENT, now);
  }

  void clear() {
    _prefs.setString(TITLE, null);
    _prefs.setString(LAST_INCIDENT, null);
  }

  void dispose() {}
}

class DefaultCounter extends StatefulWidget {
  final int days;
  final String title;
  final VoidCallback onReset;

  const DefaultCounter(
      {Key key,
      @required this.days,
      @required this.title,
      @required this.onReset})
      : super(key: key);

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.title,
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
                          "${widget.days} days.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display3,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      textColor: Theme.of(context).errorColor,
                      child: Text("Reset"),
                      onPressed: () {
                        widget.onReset();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
