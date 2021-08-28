import 'package:domain/domain.dart';
import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:dwi/core/widgets/widgets.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:dwi/features/time_counter/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: EmptyAppBar(),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ThemeChooserButton(),
            IconButton(
              tooltip: Resources.string(context, AppStrings.TITLE_SETTINGS),
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
              icon: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
      body: DefaultCounter(),
    );
  }
}

class ThemeChooserButton extends StatelessWidget {
  const ThemeChooserButton({
    Key? key,
  }) : super(key: key);

  DWITheme calculateNextTheme(AppTheme currentTheme) {
    final currentThemeIdx = DWIThemes.getThemeIdx(currentTheme);

    if (currentThemeIdx + 1 >= DWIThemes.allThemes.length) {
      return DWIThemes.allThemes[0];
    } else {
      return DWIThemes.allThemes[currentThemeIdx + 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<ThemeChooserCubit>().state.theme;
    final nextTheme = calculateNextTheme(currentTheme);

    return IconButton(
      tooltip: nextTheme.name,
      onPressed: () =>
          context.read<ThemeChooserCubit>().themeChanged(nextTheme.theme),
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: nextTheme.color,
        ),
      ),
    );

    // return InkWell(
    //   borderRadius: BorderRadius.circular(24),
    //   onTap: () =>
    //       context.read<ThemeChooserCubit>().themeChanged(nextTheme.theme),
    //   child: AnimatedContainer(
    //     duration: Duration(milliseconds: 150),
    //     width: 48,
    //     height: 48,
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         color: nextTheme.themeData.primaryColor,
    //         width: 1,
    //       ),
    //       borderRadius: BorderRadius.circular(24),
    //       color: nextTheme.color,
    //     ),
    //   ),
    // );

    // return FloatingActionButton(
    //   backgroundColor: nextTheme.color,
    //   onPressed: () =>
    //       context.read<ThemeChooserCubit>().themeChanged(nextTheme.theme),
    //   elevation: 0,
    //   focusElevation: 2,
    //   mini: true,
    // );
  }
}
