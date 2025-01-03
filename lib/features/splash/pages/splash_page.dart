import 'package:domain/domain.dart';
import 'package:dwi/core/navigation/navigation.dart';
import 'package:dwi/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// SplashPage
class SplashPage extends StatefulWidget {
  /// A splash page that randomly displays the logo of the design firm and
  /// software development firm for a couple of seconds.
  const SplashPage({super.key});

  /// Convenience route instatiaton.
  static MaterialPageRoute<void> route() => MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Ensures that you have `context` available for use.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!context.mounted) return;

        context.read<NavigationCubit>().navigateTo(Pages.counterList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: DWIThemes.getTheme(AppTheme.happyCyan).themeData,
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/launcher/dwi-foreground.png',
            width: 150,
          ),
        ),
      ),
    );
  }
}
