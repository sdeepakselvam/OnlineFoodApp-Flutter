import 'package:flutter/material.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';

class Space extends StatelessWidget {
  Space({this.isSmall = false, this.customValue});

  final bool isSmall;
  final double customValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: customValue != null
            ? customValue
            : isSmall
                ? UIDimens.size10
                : UIDimens.size20);
  }
}

class HorizontalSpace extends StatelessWidget {
  HorizontalSpace({this.isSmall = false, this.customValue});

  final bool isSmall;
  final double customValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: customValue != null
            ? customValue
            : isSmall
                ? UIDimens.size10
                : UIDimens.size20);
  }
}
