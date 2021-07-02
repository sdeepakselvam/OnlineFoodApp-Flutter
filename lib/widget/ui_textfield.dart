import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';
import 'package:online_food_app/widget/space.dart';
import '../ui_utils/styles.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {this.controller,
      this.style,
      this.labelText,
      this.prefixIcon,
      this.hintText,
      this.obscureText = false,
      this.enable = true,
      this.suffix,
      this.fullborder = true,
      this.action,
      this.onSubmitted,
      this.inputFormatter,
      this.keyboardType,
      this.maxLength,
      this.align,
      this.borderColor,
      this.title,
      this.contentPadding,
      this.borderRadius,
      this.fillColor});

  final TextEditingController controller;
  final TextStyle style;
  final String labelText;
  final Icon prefixIcon;
  final String hintText, title;
  final bool obscureText;
  final bool enable, fullborder;
  final Widget suffix;
  final TextInputAction action;
  final Function(String) onSubmitted;
  final List<TextInputFormatter> inputFormatter;
  final TextInputType keyboardType;
  final int maxLength;
  final TextAlign align;
  final Color borderColor;
  final EdgeInsets contentPadding;
  final double borderRadius;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: action ?? TextInputAction.next,
        controller: controller,
        enabled: enable,
        inputFormatters: inputFormatter,
        autofocus: false,
        maxLength: maxLength,
        cursorColor: Colors.black,
        style: style ?? Styles.appBarTitle.copyWith(fontSize: 14),
        obscureText: obscureText,
        onSubmitted: onSubmitted,
        textAlign: align ?? TextAlign.left,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          counterText: "",
          hintText: hintText,
          labelText: labelText,
          labelStyle: Styles.appBarTitle.copyWith(height: 0.5),
          isDense: true,
          contentPadding: contentPadding ?? EdgeInsets.all(UIDimens.size10),
          suffixIcon: suffix,
          prefixIcon: prefixIcon,
          border: fullborder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius ?? UIDimens.size5)),
                  borderSide: BorderSide())
              : UnderlineInputBorder(borderSide: BorderSide()),
          focusedBorder: fullborder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius ?? UIDimens.size5)),
                  borderSide: BorderSide(
                    color: Colors.lightBlueAccent,
                  ))
              : UnderlineInputBorder(borderSide: BorderSide()),
          enabledBorder: fullborder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius ?? UIDimens.size5)),
                  borderSide: BorderSide(color: borderColor ?? Colors.grey))
              : UnderlineInputBorder(borderSide: BorderSide()),
        ));
  }
}
