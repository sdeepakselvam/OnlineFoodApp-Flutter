import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:online_food_app/locale/localizations.dart';
import 'package:online_food_app/ui_utils/string_resources.dart';

class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<void> checkNetworkAndShowSnackBar(BuildContext context) async {
    bool isNetWorkAvailable = await check();
    if (!isNetWorkAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Translations.of(context)
              .text(StringResources.checkInternetConnection)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3)));
    }
  }

  void showNoInternetMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translations.of(context)
            .text(StringResources.checkInternetConnection)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3)));
  }
}
