import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  BackgroundImage({this.imagePath, this.width, this.height});
  final String imagePath;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath,
        fit: BoxFit.cover, width: width, height: height);
  }
}
