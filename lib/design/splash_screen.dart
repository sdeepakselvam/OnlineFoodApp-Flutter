import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/utils/app_configuration.dart';
import 'package:online_food_app/utils/app_preference.dart';
import 'package:online_food_app/utils/route_constant.dart';
import 'package:online_food_app/widget/background_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateSplashScreen();
}

class _StateSplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        maintainBottomViewPadding: true,
        child: Scaffold(
            body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BackgroundImage(imagePath: AppAssets.splashIcon),
          ],
        )));
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 2), _moveToNextPage);
  }

  void _moveToNextPage() async {
    bool isLoggined = await AppPreferences.getLoginStatus();
    if (isLoggined) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, Routes.introScreen);
    }
  }
}
