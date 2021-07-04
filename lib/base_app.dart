import 'dart:async';
import 'app.dart';
import 'locale/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'utils/app_configuration.dart';

enum AppEnvironment { DEVELOPMENT, PRODUCTION, QA, STAGING }
enum Flavor { BASE }

class BaseApp {
  static Future<void> initialize({
    @required ThemeData theme,
    @required onGenerateRoute,
    @required supportedLocales,
    @required AppEnvironment environment,
    @required Flavor flavor,
    @required Locale startingLocale,
    @required String baseUrl,
    @required VoidCallback onLogout,
    Widget logoWidget,
    @required isGuestFlowEnabled,
    @required String title,
  }) async {
    final App app = App(
        theme: theme,
        onGenerateRoute: onGenerateRoute,
        supportedLocales: supportedLocales,
        startingLocale: startingLocale,
        title: title);
    AppConfiguration().init(
      baseUrl: baseUrl,
      environment: environment,
      flavor: flavor,
      onLogout: onLogout,
      supportedLocals: supportedLocales,
      translationsDelegate: TranslationsDelegate(),
    );

    unawaited(
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));

    unawaited(runZoned<Future<void>>(() async {
      runApp(app);
    }, onError: (error) {
      print(error);
    }));
  }
}
