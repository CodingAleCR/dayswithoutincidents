import 'package:flutter/material.dart';
import 'package:dwi/core/localization/localization.dart';

abstract class Resources {
  static Image asset(BuildContext context, String assetName) {
    return MediaQuery.of(context).platformBrightness == Brightness.light
        ? Image.asset("assets/images/$assetName-light.png")
        : Image.asset("assets/images/$assetName-dark.png");
  }

  static String string(BuildContext context, String key) {
    return AppLocalizations.translate(context, key);
  }
}
