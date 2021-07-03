import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:online_food_app/controllers/login_controller.dart';
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
import 'package:online_food_app/widget/common_spinner.dart';
import 'package:online_food_app/widget/space.dart';
import 'package:online_food_app/widget/ui_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  LoginController _controller;

  @override
  void initState() {
    _controller = LoginController();
    _controller.init(context);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
            backgroundColor: UIColors.backgroundColor,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        _headerWidget,
                        Space(),
                        _phoneNumberTitle,
                        Space(),
                        _contactDetails,
                        Space(customValue: UIDimens.size30),
                        _continueButton,
                        Space(),
                        _orTitle,
                        Space(),
                        _trueCallerButton
                      ],
                    )),
                  ],
                )
              ],
            )));
  }

  Widget get _headerWidget => CommonAppBar(
      title: Translations.of(context).text(StringResources.login),
      description: Translations.of(context).text(StringResources.enterPhoneNo));

  Widget get _phoneNumberTitle => Padding(
      padding: const EdgeInsets.all(UIDimens.size20),
      child: Text(Translations.of(context).text(StringResources.phoneNo),
          style: Styles.boldStyle));

  Widget get _contactDetails => Container(
      margin: EdgeInsets.symmetric(horizontal: UIDimens.size20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            width: UIDimens.size65,
            height: UIDimens.size60,
            padding: EdgeInsets.all(UIDimens.size9),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: UIColors.lightGrey, width: 1),
                borderRadius:
                    BorderRadius.all(Radius.circular(UIDimens.size5))),
            child: SizedBox(
                child: CommonSpinner(
                    selectedItems: _controller.selectedCountry,
                    values: _controller.countryOptionList,
                    showText: true,
                    iconColor: Colors.black,
                    valueChanged: (value) {
                      _controller.setCountryType(value);
                    }))),
        HorizontalSpace(isSmall: true),
        Expanded(
            child: CommonTextField(
                keyboardType: TextInputType.number,
                controller: _controller.phoneNumberController,
                style: Styles.boldStyle,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: UIDimens.size15, vertical: UIDimens.size20),
                borderRadius: UIDimens.size10,
                borderColor: UIColors.lightBlack,
                fullborder: true,
                hintText:
                    Translations.of(context).text(StringResources.phoneNo)))
      ]));

  Widget get _continueButton => Container(
      height: UIDimens.size50,
      margin: EdgeInsets.symmetric(horizontal: UIDimens.size20),
      child: CommonButton(
          width: MediaQuery.of(context).size.width,
          showBorder: true,
          style: Styles.boldStyle
              .copyWith(fontSize: UIDimens.size13, color: Colors.white),
          title: Translations.of(context)
              .text(StringResources.continues)
              .toUpperCase(),
          backgroundColor: UIColors.redColor,
          onPressed: () {
            Navigator.pushNamed(context, Routes.otpScreen);
          }));

  Widget get _orTitle => Center(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: UIDimens.size20),
          child: Text(
              Translations.of(context).text(StringResources.or).toUpperCase(),
              style: Styles.boldStyle)));

  Widget get _trueCallerButton => Container(
      height: UIDimens.size50,
      margin: EdgeInsets.symmetric(horizontal: UIDimens.size20),
      padding: EdgeInsets.all(UIDimens.size5),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(UIDimens.size5))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HorizontalSpace(isSmall: true),
            CommonIcon(
                iconPath: AppAssets.trueCallerIcon,
                iconHeight: UIDimens.size40,
                iconWidth: UIDimens.size40),
            HorizontalSpace(isSmall: true),
            Text(Translations.of(context).text(StringResources.loginTrueCaller),
                style: Styles.boldStyle.copyWith(color: Colors.white))
          ]));
}
