import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

/// Defines a builder function that allows you to create a custom widget
/// that is displayed in a similar fashion as [UpgradeCard]
typedef UpgradeWidgetBuilder = Widget Function(
  BuildContext context,
  Upgrader upgrader,
);

/// A widget to display by checking upgrader info available.
class UpgradeWidget extends UpgradeBase {
  /// Creates a new [UpgradeWidget].
  UpgradeWidget({
    Key? key,
    Upgrader? upgrader,
    required this.builder,
  }) : super(upgrader ?? Upgrader.sharedInstance as Upgrader, key: key);

  /// Defines how the widget will be built. Allows the implementation of custom
  /// widgets.
  final UpgradeWidgetBuilder builder;

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    if (upgrader.debugLogging) {
      log('UpgradeWidget: build UpgradeWidget');
    }

    return FutureBuilder(
      future: state.initialized,
      builder: (BuildContext context, AsyncSnapshot<bool> processed) {
        if (processed.connectionState == ConnectionState.done &&
            processed.data != null &&
            processed.data!) {
          if (upgrader.shouldDisplayUpgrade()) {
            if (upgrader.debugLogging) {
              log('UpgradeWidget: will call builder');
            }
            return builder.call(context, upgrader);
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
