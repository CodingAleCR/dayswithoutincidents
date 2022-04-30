import 'package:dwi/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Custom colors provided for the app.
abstract class DWIColors {
  /// Brand Cyan #56F0D4
  static const Color brandCyan = Color(0xff56F0D4);

  /// Brand Cyan Shade 1 #21C1A2
  static const Color brandCyanShade1 = Color(0xff21C1A2);

  /// Brand White #F0F8FF
  static const Color brandWhite = Color(0xffF0F8FF);

  /// Brand Blue #07112E
  static const Color brandBlue = Color(0xff07112E);

  /// Brand Blue Tint 1 #273458
  static const Color brandBlueTint1 = Color(0xff273458);

  /// Brand Blue Tint 2 #707890
  static const Color brandBlueTint2 = Color(0xff707890);

  /// Brand Blue Tint 3 #E1E5FA
  static const Color brandBlueTint3 = Color(0xffE1E5FA);

  /// Additional Theme Red Color #F05656
  static const Color passionRed = Color(0xffF05656);

  /// Additional Theme Gold Color #F0E156
  static const Color goldAmber = Color(0xffF0E156);

  /// Additional Theme Purple Color #6B00D7
  static const Color justPurple = Color(0xff6B00D7);

  /// Material Color swatch based on [brandCyan]
  static final MaterialColor cyanSwatch = FromColor.fromColor(brandCyan);

  /// Material Color swatch based on [brandBlue]
  static final MaterialColor blueSwatch = FromColor.fromColor(brandBlue);

  /// Material Color swatch based on [passionRed]
  static final MaterialColor passionRedSwatch = FromColor.fromColor(passionRed);

  /// Material Color swatch based on [goldAmber]
  static final MaterialColor goldAmberSwatch = FromColor.fromColor(goldAmber);

  /// Material Color swatch based on [justPurple]
  static final MaterialColor justPurpleSwatch = FromColor.fromColor(justPurple);
}
