import 'dart:async';
import 'dart:convert';

import 'package:dwi/core/localization/localization_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'strings.dart';

/// App Localizations
class AppLocalizations {
  /// Localizations for the application based on a [locale]
  AppLocalizations(this.locale);

  /// Locale used.
  final Locale locale;

  /// Helper method to keep the code in the widgets concise
  /// Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    final localizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);

    if (localizations == null) {
      throw LocalizationException(
        'AppLocalizations not found in buildContext. '
        'Please make sure localizations is properly setup.',
        reason: LocalizationExceptionReason.invalidContext,
      );
    }

    return localizations;
  }

  /// Translates a key into a string value with the given context.
  static String translate(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context);
    return localizations.translateTo(key);
  }

  late Map<String, String> _localizedStrings;

  /// Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Load the language JSON file from the "lang" folder
  Future<bool> load() async {
    final jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map((key, dynamic value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  /// This method will be called from every widget which needs a localized text
  String translateTo(String key) {
    if (!_localizedStrings.containsKey(key)) {
      throw LocalizationException(
        'The key selected is not valid. Please check the [locale].json '
        'file and verify that it exists.',
        reason: LocalizationExceptionReason.invalidKey,
      );
    }

    return _localizedStrings[key]!;
  }
}

/// LocalizationsDelegate is a factory for a set of localized resources
/// In this case, the localized strings will be gotten in an AppLocalizations
/// object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  /// This delegate instance will never change (it doesn't even have fields!)
  /// It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
