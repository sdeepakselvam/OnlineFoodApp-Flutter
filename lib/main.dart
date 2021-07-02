import 'package:flutter/material.dart';
import 'package:online_food_app/base_app.dart';
import 'package:online_food_app/utils/app_constants.dart';
import 'package:online_food_app/utils/logout_utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'route_manager.dart' as routes;

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  ThemeData theme = getTheme();

  BaseApp.initialize(
      theme: theme,
      onGenerateRoute: routes.onGenerateRoute,
      supportedLocales: AppConstants.supportedLocals,
      environment: AppEnvironment.DEVELOPMENT,
      flavor: Flavor.BASE,
      onLogout: LogoutUtils().onLogout,
      isGuestFlowEnabled: true,
      logoWidget: Container(),
      title: AppConstants.appName,
      startingLocale: Locale("en", "EN"));
}

ThemeData getTheme() {
  return ThemeData(
      primaryColor: Color.fromRGBO(0, 205, 222, 1),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColorLight: Color.fromRGBO(25, 40, 191, 1),
      accentColor: Color.fromRGBO(175, 239, 0, 1),
      indicatorColor: Color.fromRGBO(0, 118, 255, 1),
      backgroundColor: Color.fromRGBO(249, 249, 249, 1));
}
