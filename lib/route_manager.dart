import 'package:flutter/material.dart';
import 'package:online_food_app/design/home/home_screen.dart';
import 'package:online_food_app/design/intro/intro_screen.dart';
import 'package:online_food_app/design/login/login_otp_screen.dart';
import 'package:online_food_app/design/login/login_screen.dart';
import 'package:online_food_app/design/splash_screen.dart';
import 'package:online_food_app/utils/route_constant.dart';

class RouteManager {
  MaterialPageRoute<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
        break;
      case Routes.introScreen:
        return MaterialPageRoute(builder: (context) => IntroScreen());
        break;
      case Routes.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
        break;
      case Routes.otpScreen:
        return MaterialPageRoute(builder: (context) => LoginOTPScreen());
        break;
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
        break;
    }
    return null;
  }
}

RouteFactory get onGenerateRoute => RouteManager().route;
