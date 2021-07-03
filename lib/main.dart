import 'package:flutter/material.dart';
import 'package:online_food_app/api_utils/api_config.dart';
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
      baseUrl: ApiConfig.baseUrl,
      onLogout: LogoutUtils().onLogout,
      isGuestFlowEnabled: true,
      logoWidget: Container(),
      title: AppConstants.appName,
      startingLocale: Locale("en", "EN"));
}

ThemeData getTheme() {
  return ThemeData(
      primaryColor: Color.fromRGBO(218, 33, 41, 1),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColorLight: Color.fromRGBO(218, 33, 41, 1),
      accentColor: Color.fromRGBO(218, 33, 41, 1),
      indicatorColor: Color.fromRGBO(218, 33, 41, 1),
      backgroundColor: Color.fromRGBO(218, 33, 41, 1));
}
