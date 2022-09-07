import 'package:flutter/material.dart';

/// Helper class to access resources like assets or localized strings.
abstract class Resources {
  /// Returns an image with the given [assetName]
  static Image asset(BuildContext context, String assetName) {
    return Theme.of(context).brightness == Brightness.light
        ? Image.asset('assets/images/$assetName-light.png')
        : Image.asset('assets/images/$assetName-dark.png');
  }

  /// Returns an image with the given [assetName]
  static String assetName(BuildContext context, String assetName) {
    return Theme.of(context).brightness == Brightness.light
        ? 'assets/images/$assetName-light.png'
        : 'assets/images/$assetName-dark.png';
  }
}
