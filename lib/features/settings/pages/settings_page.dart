import 'package:dwi/core/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

/// SettingsPage
class SettingsPage extends StatefulWidget {
  /// Defines the settings page shown for customizing user preferences.
  const SettingsPage({Key? key}) : super(key: key);

  /// Convenience route instatiaton.
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      );

  @override
  SettingsPageState createState() => SettingsPageState();
}

/// State fp
class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.titleActivitySettings,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.labelAbout.toUpperCase(),
                  style: Theme.of(context).textTheme.overline,
                ),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.settingsReportBug,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)!.settingsReportBugDescription,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onTap: () async {
                    final wiredash = Wiredash.of(context);
                    final info = await PackageInfo.fromPlatform();

                    wiredash.setBuildProperties(
                      buildNumber: info.buildNumber,
                      buildVersion: info.version,
                    );
                    wiredash.show();
                  },
                ),
                ListTile(
                  title: Text(
                    AppLocalizations.of(context)!.preferenceVersion,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  subtitle: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.hasError) {
                        return const SizedBox();
                      }
                      final info = snapshot.data;

                      return Text(
                        info!.version,
                        style: Theme.of(context).textTheme.caption,
                      );
                    },
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _launchURL(_codingaleUrl),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 48,
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.codeCredits,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(width: 4),
                        Resources.asset(context, 'codingale'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () => _launchURL(_perksncoUrl),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 48,
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(
                            context,
                          )!
                              .designCredits,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(width: 4),
                        Resources.asset(context, 'perksnco'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Column(),
              ),
            ),
          )
        ],
      ),
    );
  }

  final _codingaleUrl = 'https://codingale.dev';
  final _perksncoUrl = 'https://www.perksnco.design/';

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
