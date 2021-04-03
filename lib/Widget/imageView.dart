import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String image;
  final double sizeHeight;
  final double sizeWidth;
  final BoxFit boxFit;
  ImageView(this.image, this.sizeHeight, this.sizeWidth, {this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: boxFit == null ? BoxFit.cover : boxFit,
      height: sizeHeight,
      width: sizeWidth,
    );
  }
}
