import 'package:flutter/material.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';

class CommonIcon extends StatelessWidget {
  const CommonIcon(
      {this.iconPath,
      this.iconColor,
      this.iconData,
      this.iconWidth,
      this.iconHeight,
      this.onPressed});

  final String iconPath;
  final IconData iconData;
  final Color iconColor;
  final double iconWidth, iconHeight;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: iconData != null
          ? Icon(
              iconData,
              size: UIDimens.size25,
              color: iconColor,
            )
          : Image.asset(
              iconPath,
              height: iconHeight ?? UIDimens.size25,
              width: iconWidth ?? UIDimens.size25,
              color: iconColor,
              fit: BoxFit.fill,
              alignment: Alignment.topLeft,
            )
    );
  }
}
