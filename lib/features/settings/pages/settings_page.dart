import 'package:domain/domain.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/features/settings/cubit/preferences_cubit.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:environment/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wiredash/wiredash.dart';

/// SettingsPage
class SettingsPage extends StatefulWidget {
  /// Defines the settings page shown for customizing user preferences.
  const SettingsPage({super.key});

  /// Convenience route instatiaton.
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (c) => PreferencesCubit(
            c.read<PreferencesService>(),
            c.read<TimeCounterService>(),
          )..fetchPreferences(),
          child: const SettingsPage(),
        ),
      );

  @override
  SettingsPageState createState() => SettingsPageState();
}

/// State fp
class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final preferredMode = context.watch<PreferencesCubit>().state.preferredMode;
    final theme = context.watch<PreferencesCubit>().state.theme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).titleActivitySettings,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (EnvironmentConfig.ffCustomViewsEnabled) ...[
                  Text(
                    S.of(context).labelCustomization.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  ListTile(
                    title: Text(
                      'Layout',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      preferredMode.isCarousel
                          ? 'Show a single counter at a time. '
                              'Swipe left or right to change the focused '
                              'counter.'
                          : 'Display all counters at once in a list. Scroll '
                              'up or down to navigate between counters.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    trailing: Text(
                      preferredMode.isList ? 'List' : 'Carousel',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      context
                          .read<PreferencesCubit>()
                          .togglePreferredDisplayMode();
                      context.read<ThemeChooserCubit>().fetchTheme();
                    },
                  ),
                  if (preferredMode.isList) ...[
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        'List Theme',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        'Choose between a wide range of available themes'
                        ' designed by Perks&Co',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Text(
                        theme.displayName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      onTap: preferredMode.isList
                          ? () => context.read<PreferencesCubit>().toggleTheme()
                          : null,
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
                Text(
                  S.of(context).labelAbout.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                ListTile(
                  title: Text(
                    S.of(context).settingsReportBug,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    S.of(context).settingsReportBugDescription,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  onTap: () async {
                    Wiredash.of(context).show();
                    // final wiredash = Wiredash.of(context);
                    // final info = await PackageInfo.fromPlatform();

                    // wiredash.setBuildProperties(
                    //   buildNumber: info.buildNumber,
                    //   buildVersion: info.version,
                    // );
                    // wiredash.show();
                  },
                ),
                ListTile(
                  title: Text(
                    S.of(context).preferenceVersion,
                    style: Theme.of(context).textTheme.titleSmall,
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
                        style: Theme.of(context).textTheme.bodySmall,
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
                          S.of(context).codeCredits,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
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
                          S
                              .of(
                                context,
                              )
                              .designCredits,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(width: 4),
                        Resources.asset(context, 'perksnco'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Column(),
              ),
            ),
          ),
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
