import 'package:flutter/material.dart';
import 'package:online_food_app/ui_utils/app_assets.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_colors.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/widget/common_icon.dart';
import 'package:online_food_app/widget/space.dart';

class CommonAppBar extends StatelessWidget {
  CommonAppBar({this.title, this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: UIColors.appBarColor,
        padding: EdgeInsets.symmetric(
            horizontal: UIDimens.size18, vertical: UIDimens.size10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Space(isSmall: true),
          CommonIcon(
              iconPath: AppAssets.leftArrowIcon,
              iconWidth: UIDimens.size40,
              iconHeight: UIDimens.size40,
              onPressed: () {
                Navigator.pop(context);
              }),
          Space(isSmall: true),
          Padding(
            padding: const EdgeInsets.only(left: UIDimens.size5),
            child: Text(title ?? "",
                style: Styles.boldStyle
                    .copyWith(color: Colors.white, fontSize: UIDimens.size20)),
          ),
          Space(isSmall: true),
          Padding(
              padding: const EdgeInsets.only(left: UIDimens.size5),
              child: Text(description,
                  style: Styles.appBarTitle.copyWith(color: Colors.white))),
          Space(isSmall: true)
        ]));
  }
}
