import 'package:duration/locale.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Convenience date extensions
extension DurationLocaleOnContext on BuildContext {
  DurationLocale get durationLocale => S.of(this).localeName.contains('es')
      ? const SpanishDurationLanguage()
      : const EnglishDurationLocale();
}
