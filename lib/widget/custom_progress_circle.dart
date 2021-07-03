import 'package:flutter/material.dart';
import 'package:online_food_app/locale/localizations.dart';
import 'package:online_food_app/ui_utils/string_resources.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';

class ProgressCircle {
  final BuildContext context;
  bool isShowing = false;

  ProgressCircle(this.context);

  void showProgressBar({String text}) {
    if (isShowing) {
      hideProgressBar();
    }
    isShowing = true;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(UIDimens.paddingXYSmall),
            child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              CircularProgressIndicator(),
              Padding(
                  padding: EdgeInsets.all(UIDimens.paddingSmall),
                  child: Text(
                      text ??
                          Translations.of(context)
                              .text(StringResources.loading),
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: UIDimens.size20)))
            ]))));
  }

  void hideProgressBar() {
    if (isShowing) {
      Navigator.pop(context);
      isShowing = false;
    }
  }
}
