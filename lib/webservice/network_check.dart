import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

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
          content: Text("Check your Internet Connect"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3)));
    }
  }

  void showNoInternetMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Check your Internet Connect"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3)));
  }
}
