import 'package:flutter/material.dart';
import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/features/time_counter/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TimeCounterBloc>(context)..add(GetTimeCounter());
  }

  _titleInputDialog(TimeCounter counter) {
    String newTitle;
    TextEditingController controller =
        TextEditingController(text: counter.title);
    showDialog<String>(
      context: context,
      builder: (BuildContext bContext) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(bContext).translate(AppStrings.INPUT_TITLE),
          ),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(bContext)
                        .translate(AppStrings.PREFERENCE_TITLE),
                    hintText: AppLocalizations.of(bContext)
                        .translate(AppStrings.HINT_TITLE),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      newTitle = AppLocalizations.of(bContext)
                          .translate(AppStrings.DAYS_WITHOUT_INCIDENTS);
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
              child: Text(MaterialLocalizations.of(bContext).cancelButtonLabel),
              onPressed: () {
                Navigator.of(bContext).pop(newTitle);
              },
            ),
            FlatButton(
              child: Text(MaterialLocalizations.of(bContext).okButtonLabel),
              onPressed: () {
                if (newTitle != null) {
                  BlocProvider.of<TimeCounterBloc>(context)
                    ..add(UpdateTimeCounter(
                        counter: TimeCounter(
                            title: newTitle, incident: counter.incident)));
                  Navigator.of(bContext).pop(newTitle);
                }
              },
            ),
          ],
        );
      },
    );
  }

  _lastIncidentPicker(TimeCounter counter) async {
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: counter.incident,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      BlocProvider.of<TimeCounterBloc>(context)
        ..add(UpdateTimeCounter(
            counter:
                TimeCounter(title: counter.title, incident: selectedDate)));
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
          AppLocalizations.of(context).translate(AppStrings.TITLE_SETTINGS),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener<TimeCounterBloc, TimeCounterState>(
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
              return buildSettingsList(state.counter);
            } else {
              return buildSettingsList(TimeCounter.empty());
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSettingsList(TimeCounter counter) {
    return ListView(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      children: <Widget>[
        Text(
          AppLocalizations.of(context)
              .translate(AppStrings.LABEL_CUSTOMIZATION)
              .toUpperCase(),
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate(AppStrings.PREFERENCE_TITLE),
            style: Theme.of(context).textTheme.subtitle,
          ),
          subtitle: Text(
            AppLocalizations.of(context).translate(AppStrings.SUMMARY_TITLE),
            style: Theme.of(context).textTheme.caption,
          ),
          onTap: () => _titleInputDialog(counter),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate(AppStrings.PREFERENCE_DATE),
            style: Theme.of(context).textTheme.subtitle,
          ),
          subtitle: Text(
            AppLocalizations.of(context).translate(AppStrings.SUMMARY_DAY),
            style: Theme.of(context).textTheme.caption,
          ),
          onTap: () => _lastIncidentPicker(counter),
        ),
        Text(
          AppLocalizations.of(context)
              .translate(AppStrings.LABEL_ABOUT)
              .toUpperCase(),
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context)
                .translate(AppStrings.PREFERENCE_VERSION),
            style: Theme.of(context).textTheme.subtitle,
          ),
          subtitle: Text(
            "2.0.0",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).translate(AppStrings.CREDITS_LN1),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
          subtitle: Text(
            AppLocalizations.of(context).translate(AppStrings.CREDITS_LN2),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
