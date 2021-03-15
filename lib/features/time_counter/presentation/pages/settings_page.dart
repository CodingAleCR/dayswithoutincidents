import 'package:flutter/material.dart';
import 'package:dwi/core/localization/localization.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/localization/app_localizations.dart';
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
            TextButton(
              child: Text(MaterialLocalizations.of(bContext).cancelButtonLabel),
              onPressed: () {
                Navigator.of(bContext).pop(newTitle);
              },
            ),
            TextButton(
              child: Text(MaterialLocalizations.of(bContext).okButtonLabel),
              onPressed: () {
                if (newTitle != null) {
                  BlocProvider.of<TimeCounterBloc>(context)
                    ..add(
                      UpdateTimeCounter(
                        counter: TimeCounter(
                          title: newTitle,
                          incident: counter.incident,
                        ),
                      ),
                    );
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
    DateTime today = DateTime.now();
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: counter.incident,
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 1),
    );

    if (selectedDate != null) {
      BlocProvider.of<TimeCounterBloc>(context)
        ..add(
          UpdateTimeCounter(
            counter: TimeCounter(
              title: counter.title,
              incident: selectedDate,
            ),
          ),
        );
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
        listenWhen: (prevState, state) => (prevState is TimeCounterLoading),
        listener: (context, state) {
          if (state is TimeCounterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
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
    return Stack(
      children: [
        ListView(
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
                AppLocalizations.of(context)
                    .translate(AppStrings.PREFERENCE_TITLE),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                AppLocalizations.of(context)
                    .translate(AppStrings.SUMMARY_TITLE),
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () => _titleInputDialog(counter),
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)
                    .translate(AppStrings.PREFERENCE_DATE),
                style: Theme.of(context).textTheme.subtitle2,
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
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                "2.0.1",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Center(
              child: InkWell(
                onTap: _launchURL,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: 232,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate(AppStrings.HOME_CREDITS),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      MediaQuery.of(context).platformBrightness ==
                              Brightness.light
                          ? Image.asset("assets/images/codingale-light.png")
                          : Image.asset("assets/images/codingale-dark.png"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  final _url = 'https://codingale.dev';

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
