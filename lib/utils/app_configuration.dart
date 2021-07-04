import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:online_food_app/utils/app_preference.dart';
import '../locale/localizations.dart';
import '../base_app.dart';

class AppConfiguration {
  // next three lines makes this class a Singleton
  static AppConfiguration _instance = AppConfiguration._internal();

  AppConfiguration._internal();

  factory AppConfiguration() => _instance;

  bool _loginStatus = false;
  AppEnvironment _environment;
  Flavor _flavor;
  String _baseUrl;
  List<Locale> _supportedLocals;
  Locale _currentLocale;
  TranslationsDelegate _translationsDelegate;
  String _apiKey;

  Future<void> init({
    @required AppEnvironment environment,
    @required Flavor flavor,
    @required String baseUrl,
    @required onLogout,
    @required translationsDelegate,
    @required supportedLocals,
  }) async {
    _environment = environment;
    _flavor = flavor;
    _onLogout = onLogout;
    _supportedLocals = supportedLocals;
    _translationsDelegate = translationsDelegate;
  }


  VoidCallback _onLogout;

  String get apiKey => _apiKey;

  Function get onLogout => _onLogout;

  bool get isUserLoggedIn => _loginStatus;

  AppEnvironment get currentEnvironment => _environment;

  Flavor get flavor => _flavor;

  String get flavorName => _flavor
      .toString()
      .substring(_flavor.toString().indexOf('.') + 1)
      .toLowerCase();

  String get baseUrl => _baseUrl;

  String get currentLanguage => _currentLocale.languageCode;

  List<Locale> get supportedLocals => _supportedLocals;

  TranslationsDelegate get translationsDelegate => _translationsDelegate;

  Locale get currentLocale => _currentLocale;

  void changeCurrentLocale(Locale locale) {
    assert(locale != null);
    _currentLocale = locale;
  }

  Future<Locale> setUserLanguage() async {
    String language = await AppPreferences.getUserLanguage();
    if (language != null && language.isNotEmpty) {
      final List<String> locale = language.split('_');
      return Locale(locale[0], locale[1]);
    }
    return null;
  }

  void setUserIsLoggedIn() {
    _loginStatus = true;
    AppPreferences.setLoginStatus(true);
  }

  Future<void> setUserIsLoggedOut() async {
    await AppPreferences.logoutClearPreferences();
  }
}
