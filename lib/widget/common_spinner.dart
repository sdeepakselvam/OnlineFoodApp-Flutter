import 'package:flutter/material.dart';
import 'package:online_food_app/model/spinner_model.dart';
import 'package:online_food_app/ui_utils/styles.dart';
import 'package:online_food_app/ui_utils/ui_dimens.dart';

class CommonSpinner extends StatefulWidget {
  CommonSpinner(
      {this.selectedItems,
      this.values,
      this.valueChanged,
      this.showText = false,
      this.iconColor,
      this.hint});

  final List<SpinnerModel> values;
  final SpinnerModel selectedItems;
  final ValueChanged<SpinnerModel> valueChanged;
  final bool showText;
  final Color iconColor;
  final String hint;

  @override
  State<StatefulWidget> createState() => _CommonSpinner();
}

class _CommonSpinner extends State<CommonSpinner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: UIDimens.size30,
      width: UIDimens.size30,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SpinnerModel>(
          hint:
              Center(child: Text(widget.hint ?? "", style: Styles.appBarTitle)),
          focusColor: Colors.white,
          value: widget.selectedItems,
          selectedItemBuilder: (context) {
            List<Widget> widgets = [];
            widget.values.forEach((value) {
              widgets.add(DropdownMenuItem<SpinnerModel>(
                value: value,
                child: widget.showText
                    ? Text(
                        value.name,
                        style: Styles.appBarTitle.copyWith(color: Colors.black),
                      )
                    : Container(),
              ));
            });
            return widgets;
          },
          isExpanded: false,
          iconSize: UIDimens.size20,
          iconEnabledColor: widget.iconColor ?? Colors.white,
          itemHeight: UIDimens.size50,
          onChanged: (SpinnerModel data) {
            setState(() {
              widget.valueChanged(data);
            });
          },
          items: widget.values
              .map<DropdownMenuItem<SpinnerModel>>((SpinnerModel value) {
            return DropdownMenuItem<SpinnerModel>(
              value: value,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(UIDimens.zero),
                child: Text(
                  value.name ?? "",
                  style: Styles.appBarTitle.copyWith(color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
