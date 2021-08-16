import 'package:dwi/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

abstract class DWIColors {
  // Brand
  static Color brandCyan = HexColor.fromHex("#56F0D4");
  static Color brandCyanShade1 = HexColor.fromHex("#21C1A2");
  static Color brandWhite = HexColor.fromHex("#F0F8FF");
  static Color brandBlue = HexColor.fromHex("#07112E");
  static Color brandBlueTint1 = HexColor.fromHex("#273458");
  static Color brandBlueTint2 = HexColor.fromHex("#707890");
  static Color brandBlueTint3 = HexColor.fromHex("#E1E5FA");

  static final MaterialColor cyanSwatch = FromColor.fromColor(brandCyan);
  static final MaterialColor blueSwatch = FromColor.fromColor(brandBlue);
}
