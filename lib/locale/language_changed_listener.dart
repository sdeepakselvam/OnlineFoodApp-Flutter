import 'dart:ui';

import '../utils/app_configuration.dart';

/// [LanguageChangedListener] is used to notify the app when the language is changed.
class LanguageChangedListener {
  /// [onChange] helps
  void onChange(Locale locale) {
    AppConfiguration().changeCurrentLocale(locale);
  }
}
