import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Gets the correct time counter string from locale.
String timeCounterCount(
  BuildContext context,
  Duration duration,
) {
  if (duration.inDays > 0) {
    return S.of(context).dayCount(duration.inDays);
  } else if (duration.inHours > 0) {
    return S.of(context).hourCount(
          duration.inHours,
        );
  } else if (duration.inMinutes > 0) {
    return S.of(context).minuteCount(
          duration.inMinutes,
        );
  } else {
    return S.of(context).minuteCount(
          0,
        );
  }
}

/// Gets the correct time counter string from locale.
String timeCounterHourCount(
  BuildContext context,
  Duration duration,
) {
  if (duration.inDays > 0) {
    return S.of(context).dayCount(duration.inDays);
  } else if (duration.inHours > 0) {
    return S.of(context).hourCount(
          duration.inHours,
        );
  } else {
    return S.of(context).hourCount(
          0,
        );
  }
}
