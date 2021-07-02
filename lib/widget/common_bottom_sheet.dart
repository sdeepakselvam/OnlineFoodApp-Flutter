import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:online_food_app/controllers/home_controller.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/widget/common_icon.dart';
import 'package:online_food_app/widget/space.dart';
import 'package:online_food_app/widget/ui_textfield.dart';

class CustomBottomSheetWidget {
  final BuildContext context;
  final HomeController homeController;

  CustomBottomSheetWidget(this.homeController, {this.context});

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _headerWidget,
                Space(isSmall: true),
                _addressTitle,
                Space(isSmall: true),
                _homeAddress,
                Space(isSmall: true),
                _workAddress,
                Space(customValue: UIDimens.size15),
                _manualAddressField,
                Space(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _switch =>
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return InkWell(
            onTap: () {
              setState(() {
                homeController.setActiveStatus();
              });
            },
            child: CommonIcon(
              onPressed: () {
                setState(() {
                  homeController.setActiveStatus();
                });
              },
              iconWidth: UIDimens.size35,
              iconHeight: UIDimens.size30,
              iconPath: homeController.isActive
                  ? AppAssets.switchOnIcon
                  : AppAssets.switchOffIcon,
            ));
      });

  Widget get _headerWidget => Container(
        color: UIColors.redColor,
        padding: EdgeInsets.all(UIDimens.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Device Location",
                style: Styles.boldStyle.copyWith(color: Colors.white)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("For accurate address and hassle free",
                    style: Styles.appBarTitle.copyWith(color: Colors.white)),
                _switch
              ],
            ),
            Space(customValue: UIDimens.size5),
            Text("deliver use device Location",
                style: Styles.appBarTitle.copyWith(color: Colors.white)),
            Space(isSmall: true)
          ],
        ),
      );

  Widget get _addressTitle => Padding(
        padding: EdgeInsets.all(UIDimens.size20),
        child: Text(
          "Saved Address",
          style: Styles.boldStyle,
        ),
      );

  Widget get _homeAddress =>
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return InkWell(
          onTap: () {
            setState(() {

            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UIDimens.size20, vertical: UIDimens.size5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonIcon(
                  iconData: Icons.home_outlined,
                  iconColor: Colors.grey,
                ),
                HorizontalSpace(isSmall: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("HOME", style: Styles.boldStyle),
                    Space(customValue: UIDimens.paddingXXSmall),
                    Text("47 W 13th St, New York, NY 10011, USA",
                        style: Styles.appBarTitle.copyWith(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        );
      });

  Widget get _workAddress =>
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return InkWell(
          onTap: () {
            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UIDimens.size20, vertical: UIDimens.size5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonIcon(
                  iconData: Icons.home_outlined,
                  iconColor: Colors.grey,
                ),
                HorizontalSpace(isSmall: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Work", style: Styles.boldStyle),
                    Space(customValue: UIDimens.paddingXXSmall),
                    Text("47 W 13th St, New York, NY 10011, USA",
                        style: Styles.appBarTitle.copyWith(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        );
      });

  Widget get _manualAddressField => Container(
        margin: EdgeInsets.symmetric(horizontal: UIDimens.size20),
        height: UIDimens.size40,
        child: CommonTextField(
          style: Styles.boldStyle,
          fillColor: UIColors.lightGrey,
          contentPadding: EdgeInsets.symmetric(
              horizontal: UIDimens.size15, vertical: UIDimens.size15),
          borderRadius: UIDimens.size10,
          borderColor: Colors.transparent,
          fullborder: true,
          hintText: "Enter address manually",
        ),
      );
}
