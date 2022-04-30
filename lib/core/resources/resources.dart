import 'package:dwi/core/localization/localization.dart';
import 'package:flutter/material.dart';

/// Helper class to access resources like assets or localized strings.
abstract class Resources {
  /// Returns an image with the given [assetName]
  static Image asset(BuildContext context, String assetName) {
    return Theme.of(context).brightness == Brightness.light
        ? Image.asset('assets/images/$assetName-light.png')
        : Image.asset('assets/images/$assetName-dark.png');
  }

  /// Returns a localized string for the [key] with the given [context]
  static String string(BuildContext context, String key) {
    return AppLocalizations.translate(context, key);
  }
}
