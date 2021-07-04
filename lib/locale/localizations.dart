import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:intl/intl.dart';
import 'package:online_food_app/base_app.dart';
import 'package:online_food_app/locale/language_locale.dart';
import '../utils/app_configuration.dart';
import 'language_changed_listener.dart';

class Translations {
  Translations(this.locale) {
    _localizedValues = null;
  }

  static String getLocaleName(Locale locale) {
    final String language =
        LanguageLocal().getDisplayLanguage(locale.languageCode)['nativeName'];
    return '$language (${locale.countryCode})';
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static void _setIntlLocale(Locale locale) {
    Intl.defaultLocale = locale.toString();
  }

  static Future<Translations> load(Locale locale,
      {String jsonContent, String marketName, List<String> packages}) async {
    _setIntlLocale(locale);

    Translations translations = Translations(locale);

    _localizedValues ??= {};

    if (jsonContent != null) {
      _localizedValues.addAll(json.decode(jsonContent));
    }
    if (locale != null) {
      _localizedValues.addAll(await _getPackageLocaleJson(locale));
    }

    return translations;
  }

  static Future<Map<dynamic, dynamic>> _getPackageLocaleJson(
      Locale locale) async {
    final String localeResource = "locale/i18n_${locale.languageCode}.json";
    return _getStringValues(localeResource, locale);
  }

  static Future<Map<dynamic, dynamic>> _getStringValues(
      final String path, final Locale locale) async {
    Map<dynamic, dynamic> localizedValues = {};
    try {
      String localeJson;
      // * Json files larger than 10239 bytes cause issues when using flutter drive. For test configuration more time-consuming but working method is used.
      // * Submitted issue on flutter github: https://github.com/flutter/flutter/issues/44182
      if (AppConfiguration().currentEnvironment == AppEnvironment.QA) {
        final ByteData data = await rootBundle.load(path);
        localeJson = utf8.decode(data.buffer.asUint8List());
      } else {
        localeJson = await rootBundle.loadString(path);
      }
      try {
        LanguageChangedListener().onChange(locale);
        localizedValues = json.decode(localeJson);
      } catch (e) {
        return null;
      }
    } catch (ex) {
      print(
          'Could not find assets for ${locale.languageCode}-${locale.countryCode} while loading $path. Using default ${AppConfiguration().supportedLocals.first.languageCode}-${AppConfiguration().supportedLocals.first.countryCode}.');
      return null;
    }
    return localizedValues;
  }

  String get currentLanguage => locale.languageCode;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  TranslationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppConfiguration().supportedLocals.contains(locale);

  @override
  Future<Translations> load(Locale locale) {
    return Translations.load(locale);
  }

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
