import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

/// Creates a new [UpgraderButton].
class UpgraderButton extends UpgradeBase {
  /// Creates a new [UpgraderButton].
  UpgraderButton({
    Key? key,
    Upgrader? upgrader,
  }) : super(upgrader ?? Upgrader.sharedInstance as Upgrader, key: key);

  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    return FutureBuilder(
      future: state.initialized,
      builder: (BuildContext context, AsyncSnapshot<bool> processed) {
        if (processed.connectionState == ConnectionState.done &&
            processed.data != null &&
            processed.data!) {
          if (upgrader.shouldDisplayUpgrade()) {
            return IconButton(
              onPressed: () {
                upgrader.checkVersion(context: context);
              },
              icon: const Icon(Icons.upload),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
