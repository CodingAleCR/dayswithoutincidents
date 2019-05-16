import 'package:dwi/domain/bloc/bloc.dart';
import 'package:dwi/domain/models/day_counter.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Bloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Bloc();
    _bloc.init().then((instance) {
      instance.fetchCounter();
    });
  }

  _titleInputDialog(DayCounter counter) {
    String newTitle;
    TextEditingController controller =
        TextEditingController(text: counter.title);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
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
  }

  _lastIncidentPicker(DayCounter counter) async {
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: counter.incident,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      _bloc.setIncident(selectedDate);
    }
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
                onTap: () => _titleInputDialog(counter),
              ),
              ListTile(
                title: Text(
                  "Last Incident",
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  "This is the date of the last incident.",
                  style: Theme.of(context).textTheme.caption,
                ),
                onTap: () => _lastIncidentPicker(counter),
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
