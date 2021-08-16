import 'package:dwi/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/localization/app_localizations.dart';
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
    String? newTitle;
    TextEditingController controller =
        TextEditingController(text: counter.title);
    showDialog<String>(
      context: context,
      builder: (BuildContext bContext) {
        return AlertDialog(
          title: Text(
            Resources.string(bContext, AppStrings.INPUT_TITLE),
          ),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: Resources.string(
                      bContext,
                      AppStrings.PREFERENCE_TITLE,
                    ),
                    hintText: Resources.string(
                      bContext,
                      AppStrings.HINT_TITLE,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      newTitle = Resources.string(
                        bContext,
                        AppStrings.DAYS_WITHOUT_INCIDENTS,
                      );
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
                          id: counter.id,
                          title: newTitle!,
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
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: counter.incident!,
      firstDate: DateTime(today.year - 1),
      lastDate: DateTime(today.year + 1),
    );

    if (selectedDate != null) {
      BlocProvider.of<TimeCounterBloc>(context)
        ..add(
          UpdateTimeCounter(
            counter: TimeCounter(
              id: counter.id,
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
        title: Text(
          Resources.string(context, AppStrings.TITLE_SETTINGS),
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
                Resources.string(context, AppStrings.LABEL_CUSTOMIZATION)
                    .toUpperCase(),
                style: Theme.of(context).textTheme.overline!),
            ListTile(
              title: Text(
                Resources.string(context, AppStrings.PREFERENCE_TITLE),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                Resources.string(context, AppStrings.SUMMARY_TITLE),
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () => _titleInputDialog(counter),
            ),
            ListTile(
              title: Text(
                Resources.string(context, AppStrings.PREFERENCE_DATE),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                Resources.string(context, AppStrings.SUMMARY_DAY),
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () => _lastIncidentPicker(counter),
            ),
            Text(
              Resources.string(context, AppStrings.LABEL_ABOUT).toUpperCase(),
              style: Theme.of(context).textTheme.overline!,
            ),
            ListTile(
              title: Text(
                Resources.string(context, AppStrings.PREFERENCE_VERSION),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return SizedBox();
                    }
                    final info = snapshot.data;

                    return Text(
                      info!.version,
                      style: Theme.of(context).textTheme.caption,
                    );
                  }),
            ),
          ],
        ),
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _launchURL(_codingaleUrl),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 48,
                      width: 250,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Resources.string(context, AppStrings.CODE_CREDITS),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          SizedBox(width: 4),
                          Resources.asset(context, "codingale"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  InkWell(
                    onTap: () => _launchURL(_perksncoUrl),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: 48,
                      width: 250,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Resources.string(
                              context,
                              AppStrings.DESIGN_CREDITS,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          SizedBox(width: 4),
                          Resources.asset(context, "perksnco"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  final _codingaleUrl = 'https://codingale.dev';
  final _perksncoUrl = 'https://www.perksnco.design/';

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
