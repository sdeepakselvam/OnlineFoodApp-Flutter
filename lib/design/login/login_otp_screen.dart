import 'package:flutter/material.dart';
import 'package:online_food_app/controllers/login_otp_controller.dart';
import 'package:online_food_app/locale/localizations.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/ui_utils/string_resources.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/utils/route_constant.dart';
import 'package:online_food_app/widget/common_app_bar.dart';
import 'package:online_food_app/widget/common_button.dart';
import 'package:online_food_app/widget/common_icon.dart';
import 'package:online_food_app/widget/space.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LoginOTPScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginOTPScreen();
}

class _LoginOTPScreen extends State<LoginOTPScreen> {
  OTPController _controller;

  @override
  void initState() {
    _controller = OTPController();
    _controller.init(context);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void stopTimer() {
    if (_controller.countDownTimer.isActive) {
      _controller.countDownTimer.cancel();
    }
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
      description: Translations.of(context)
          .text(StringResources.enterOTPSent) //need to add PhoneNo
      );

  Widget get _otpTitle => Padding(
      padding: const EdgeInsets.all(UIDimens.size20),
      child: Text(Translations.of(context).text(StringResources.enterOTP),
          style: Styles.boldStyle));

  Widget get _otpField => Container(
      color: Colors.transparent,
      child: PinPut(
          fieldsCount: 6,
          textStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          enabled: true,
          controller: _controller.otpController,
          fieldsAlignment: MainAxisAlignment.center,
          eachFieldMargin: EdgeInsets.all(UIDimens.size5),
          submittedFieldDecoration: BoxDecoration(
              border:
                  Border.all(width: UIDimens.size2, color: UIColors.lightGrey)),
          followingFieldDecoration: BoxDecoration(
              border:
                  Border.all(width: UIDimens.size2, color: UIColors.lightGrey)),
          disabledDecoration: BoxDecoration(
              border:
                  Border.all(width: UIDimens.size2, color: UIColors.lightGrey)),
          selectedFieldDecoration: BoxDecoration(
              border:
                  Border.all(width: UIDimens.size2, color: UIColors.lightGrey)),
          preFilledWidget: Container()));

  Widget get _timeCounter => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonIcon(iconPath: AppAssets.timeStampIcon),
            HorizontalSpace(),
            Text(_controller.timeDisplay, style: Styles.boldStyle)
          ]);

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
          onPressed: () {
            stopTimer();
            Navigator.pushNamed(context, Routes.homeScreen);
          }));
}
