import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui_utils/styles.dart';
import '../ui_utils/ui_dimens.dart';

class CommonButton extends StatefulWidget {
  CommonButton(
      {this.onPressed,
      this.title,
      this.width,
      this.height,
      this.showBorder = true,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.style,
      this.padding});
  final Function onPressed;
  final String title;
  final double width, borderRadius, height;
  final Color backgroundColor, borderColor;
  final bool showBorder;
  final TextStyle style;
  final EdgeInsets padding;

  @override
  State<StatefulWidget> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          height: widget.height,
          width: widget.width,
          padding: widget.padding ??
              EdgeInsets.symmetric(
                  horizontal: UIDimens.paddingYSmall,
                  vertical: UIDimens.size12),
          decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              border: widget.showBorder
                  ? Border.all(
                      color: widget.borderColor ?? Colors.grey, width: 1)
                  : null,
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? UIDimens.size5))),
          child: Center(
            child:
                Text(widget.title, style: widget.style ?? Styles.appBarTitle),
          )),
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed();
        }
      },
    );
  }
}
