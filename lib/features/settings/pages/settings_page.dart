import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Resources.string(context, AppStrings.TITLE_SETTINGS),
        ),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSettingsList() {
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          children: <Widget>[
            // Text(
            //     Resources.string(context, AppStrings.LABEL_CUSTOMIZATION)
            //         .toUpperCase(),
            //     style: Theme.of(context).textTheme.overline!),
            // ListTile(
            //   title: Text(
            //     Resources.string(context, AppStrings.PREFERENCE_TITLE),
            //     style: Theme.of(context).textTheme.subtitle2,
            //   ),
            //   subtitle: Text(
            //     Resources.string(context, AppStrings.SUMMARY_TITLE),
            //     style: Theme.of(context).textTheme.caption,
            //   ),
            //   onTap: () => _titleInputDialog(counter),
            // ),
            // ListTile(
            //   title: Text(
            //     Resources.string(context, AppStrings.PREFERENCE_DATE),
            //     style: Theme.of(context).textTheme.subtitle2,
            //   ),
            //   subtitle: Text(
            //     Resources.string(context, AppStrings.SUMMARY_DAY),
            //     style: Theme.of(context).textTheme.caption,
            //   ),
            //   onTap: () => _lastIncidentPicker(counter),
            // ),
            Text(
              Resources.string(context, AppStrings.LABEL_ABOUT).toUpperCase(),
              style: Theme.of(context).textTheme.overline!,
            ),
            ListTile(
              title: Text(
                Resources.string(context, AppStrings.SETTINGS_REPORT_BUG),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                Resources.string(
                    context, AppStrings.SETTINGS_REPORT_BUG_DESCRIPTION),
                style: Theme.of(context).textTheme.caption,
              ),
              onTap: () async {
                final info = await PackageInfo.fromPlatform();

                Wiredash.of(context)?.setBuildProperties(
                  buildNumber: info.buildNumber,
                  buildVersion: info.version,
                );
                Wiredash.of(context)?.show();
              },
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
