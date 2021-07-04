import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:online_food_app/controllers/login_otp_controller.dart';
import 'package:online_food_app/locale/localizations.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/ui_utils/string_resources.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/widget/common_app_bar.dart';
import 'package:online_food_app/widget/common_button.dart';
import 'package:online_food_app/widget/common_icon.dart';
import 'package:online_food_app/widget/space.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:http/http.dart' as http;

class LoginOTPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginOTPScreen();
}

class _LoginOTPScreen extends State<LoginOTPScreen> {
  OTPController _controller;

  @override
  void initState() {
    _controller = OTPController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.init(context));
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void stopTimer() {
    setState(() {
      if (_controller.countDownTimer.isActive) {
        _controller.countDownTimer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
            backgroundColor: UIColors.backgroundColor,
            body: Stack(fit: StackFit.expand, children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: ListView(children: [
                  _headerWidget,
                  Space(),
                  _otpTitle,
                  Space(),
                  _otpField,
                  Space(),
                  _timeCounter,
                  Space(),
                  Space(),
                  _continueButton
                ]))
              ])
            ])));
  }

  Widget get _headerWidget => CommonAppBar(
      title: Translations.of(context).text(StringResources.verifyPhoneNo),
      description: Translations.of(context).text(StringResources.enterOTPSent) +
          " " +
          _controller.phoneNumber);

  Widget get _otpTitle => Padding(
      padding: const EdgeInsets.all(UIDimens.size20),
      child: Text(Translations.of(context).text(StringResources.enterOTP),
          style: Styles.boldStyle));

  Widget get _otpField => Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: UIDimens.size20),
      child: PinPut(
          fieldsCount: 6,
          onSubmit: (String pin) => {},
          focusNode: FocusNode(),
          textStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          controller: _controller.otpController,
          eachFieldMargin: EdgeInsets.all(UIDimens.size5),
          submittedFieldDecoration: BoxDecoration(
              border: Border.all(width: UIDimens.size2, color: Colors.grey)),
          followingFieldDecoration: BoxDecoration(
              border: Border.all(width: UIDimens.size2, color: Colors.grey)),
          selectedFieldDecoration: BoxDecoration(
              border: Border.all(width: UIDimens.size2, color: Colors.grey))));

  Widget get _timeCounter => InkWell(
        onTap: () {
          if (_controller.isEnabledResendButton) {
            Navigator.pop(context);
          }
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_controller.isEnabledResendButton) ...[
                CommonIcon(iconPath: AppAssets.timeStampIcon),
                HorizontalSpace(),
                Text(_controller.timeDisplay, style: Styles.boldStyle)
              ],
              if (_controller.isEnabledResendButton) ...[
                HorizontalSpace(),
                Text(
                    Translations.of(context)
                        .text(StringResources.otpNotReceived),
                    style: Styles.boldStyle),
                Spacer(),
                CommonIcon(iconPath: AppAssets.resendIcon),
                HorizontalSpace(),
                Text(Translations.of(context).text(StringResources.resend),
                    style: Styles.boldStyle.copyWith(color: UIColors.redColor)),
                HorizontalSpace()
              ]
            ]),
      );

  Widget get _continueButton => Container(
      height: UIDimens.size50,
      margin: EdgeInsets.symmetric(horizontal: UIDimens.size20),
      child: CommonButton(
          width: MediaQuery.of(context).size.width,
          showBorder: false,
          style: Styles.boldStyle
              .copyWith(fontSize: UIDimens.size13, color: Colors.white),
          title: Translations.of(context).text(StringResources.verify),
          backgroundColor:
              _controller.isEnable ? UIColors.redColor : UIColors.inActiveColor,
          onPressed: () async {
            if (_controller.isEnable) {
              stopTimer();
              FocusScope.of(context).requestFocus(new FocusNode());
              await _controller.signInToLogin();
            }
          }));
}
