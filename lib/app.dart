import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/utils/route_constant.dart';

import 'utils/app_configuration.dart';

class App extends StatelessWidget {
  const App(
      {@required this.theme,
        @required this.onGenerateRoute,
        @required this.supportedLocales,
        @required this.title,
        this.startingLocale});

  final ThemeData theme;

  final RouteFactory onGenerateRoute;

  final List<Locale> supportedLocales;

  final Locale startingLocale;

  final String title;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(UIColors.appBarColor);
    FlutterStatusbarcolor.setNavigationBarColor(UIColors.appBarColor);

    return MaterialApp(
      title: title,
      theme: theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        AppConfiguration().translationsDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale deviceLocale, Iterable<Locale> supportedLocales) {
        if (startingLocale != null) {
          return startingLocale;
        }
        return supportedLocales.contains(deviceLocale)
            ? deviceLocale
            : supportedLocales.firstWhere(
                (local) => local.languageCode == deviceLocale.languageCode,
            orElse: () => supportedLocales.first);
      },
      supportedLocales: supportedLocales,
      initialRoute: Routes.splash,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
