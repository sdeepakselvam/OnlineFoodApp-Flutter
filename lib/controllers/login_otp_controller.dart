import 'dart:async';

import 'package:flutter/cupertino.dart';

class OTPController extends ChangeNotifier {
  BuildContext _context;

  TextEditingController _otpController = TextEditingController();
  TextEditingController get otpController => _otpController;

  bool _isEnabledResendButton = false;

  bool get isEnabledResendButton => _isEnabledResendButton;

  bool get isEnable => _otpController.text.isNotEmpty && _otpController.text.length == 6;

  Timer countDownTimer;

  String _timeDisplay = "00:00";

  String get timeDisplay => _timeDisplay;

  static const duration = const Duration(seconds: 1);

  int secondsPassed = 60;

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

  void init(BuildContext context) {
    _context = context;
    notifyListeners();
  }
}
