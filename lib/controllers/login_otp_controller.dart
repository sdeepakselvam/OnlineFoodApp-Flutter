import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_food_app/model/login/login_otp_request.dart';
import 'package:online_food_app/model/login/login_otp_response.dart';
import 'package:online_food_app/repository/user_repository.dart';
import 'package:online_food_app/utils/app_constants.dart';
import 'package:online_food_app/utils/app_preference.dart';
import 'package:online_food_app/utils/route_constant.dart';
import 'package:package_info/package_info.dart';

class OTPController extends ChangeNotifier {
  BuildContext _context;

  UserProfileRepository _userProfileRepository = UserProfileRepository();

  TextEditingController _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;

  bool _isEnabledResendButton = false;

  bool get isEnabledResendButton => _isEnabledResendButton;

  bool get isEnable => _otpController.text.isNotEmpty;

  Timer countDownTimer;

  String _timeDisplay = "00:00";

  String get timeDisplay => _timeDisplay;

  static const duration = const Duration(seconds: 1);

  int secondsPassed = 60;

  String _ipAddress;
  String get ipAddress => _ipAddress;

  String _deviceID;
  String get deviceID => _deviceID;

  String _osVersion;
  String get osVersion => _osVersion;

  String _appVersion;
  String get appVersion => _appVersion;

  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;

  void handleTick() {
    if (!_isEnabledResendButton) {
      secondsPassed = secondsPassed - 1;
      int seconds = secondsPassed % 60;
      int minutes = secondsPassed ~/ 60;
      _timeDisplay = minutes.toString().padLeft(2, '0') +
          ":" +
          seconds.toString().padLeft(2, '0');
      if (secondsPassed == 0) {
        _isEnabledResendButton = true;
      } else {
        _isEnabledResendButton = false;
      }
      notifyListeners();
    }
  }

  Future<void> startTimer() {
    countDownTimer = Timer.periodic(duration, (Timer t) {
      if (secondsPassed > 0) {
        handleTick();
      } else {
        _isEnabledResendButton = true;
      }
    });
    notifyListeners();
  }

  Future<void> deviceDetails() async {
    _phoneNumber = await AppPreferences.getPhoneNumber();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    _deviceID = androidInfo.androidId;
    _osVersion = androidInfo.version.release;
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      _appVersion = packageInfo.version;
    });
    getIPAddress();
    notifyListeners();
  }

  Future getIPAddress() async {
    for (var interface in await NetworkInterface.list()) {
      _ipAddress = interface.addresses.first.address;
    }
    notifyListeners();
  }

  Future<void> signInToLogin() async {
    LoginOTPResponse response = await _userProfileRepository.postSignInApi(
        _context,
        LoginOTPRequest(
          otp: _otpController.text.trim(),
          phoneNumber: _phoneNumber,
          countryCode: await AppPreferences.getCountryCode(),
          deviceInfo: DeviceInfo(
              appVersion: _appVersion,
              deviceId: _deviceID,
              ip: _ipAddress,
              osVersion: _osVersion,
              platform: AppConstants.android,
              pushToken: "123456"),
        ));
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(_context, Routes.homeScreen);
    }
    notifyListeners();
  }

  void init(BuildContext context) {
    _context = context;
    startTimer();
    deviceDetails();
    notifyListeners();
  }
}
