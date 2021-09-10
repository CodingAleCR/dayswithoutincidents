import 'package:dwi/core/localization/localization.dart';
import 'package:dwi/core/resources/resources.dart';
import 'package:dwi/core/widgets/widgets.dart';
import 'package:dwi/features/theme_chooser/cubit/theme_chooser_cubit.dart';
import 'package:dwi/features/time_counter/cubit/time_counter_cubit.dart';
import 'package:dwi/features/time_counter/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/default_counter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // BlocProvider.of<TimeCounterBloc>(context)..add(GetTimeCounter());
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
            _ThemeChooserButton(),
            _CustomizeCounterButton(),
          ],
        ),
      ),
      body: DefaultCounter(),
    );
  }
}

class _CustomizeCounterButton extends StatelessWidget {
  const _CustomizeCounterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: Resources.string(context, AppStrings.TITLE_SETTINGS),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (routeContext) {
              return BlocProvider.value(
                value: BlocProvider.of<TimeCounterCubit>(context),
                child: SettingsPage(),
              );
            },
          ),
        );
      },
      icon: Icon(Icons.settings_outlined),
    );
  }
}

class _ThemeChooserButton extends StatelessWidget {
  const _ThemeChooserButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: Resources.string(context, AppStrings.THEME_CUSTOMIZATION),
      onPressed: () => context.read<ThemeChooserCubit>().nextTheme(),
      icon: Icon(Icons.palette),
    );
  }
}
