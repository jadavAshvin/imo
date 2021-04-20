import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle textStyle14() {
  return TextStyle(
    fontSize: 14,
    color: black,
  );
}

TextStyle textStyleBlack(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    color: black,
  );
}

TextStyle textStyleWhite(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    color: white,
  );
}

TextStyle textStyle16BoldWhite(double fontSize) {
  return TextStyle(fontSize: fontSize, color: black, fontWeight: FontWeight.bold);
}

TextStyle textStyle16Bold(double fontSize) {
  return TextStyle(fontSize: fontSize, color: primaryColor, fontWeight: FontWeight.bold);
}

TextStyle textFieldStyle20() {
  return TextStyle(
    fontSize: 20,
    color: black,
  );
}

TextStyle textFieldStyle20Bold() {
  return TextStyle(fontSize: 20, color: black, fontWeight: FontWeight.bold);
}

TextStyle textFieldStyle20BoldUnderLine() {
  return TextStyle(fontSize: 20, decoration: TextDecoration.underline, color: black, fontWeight: FontWeight.bold);
}

TextStyle textFieldStyle18() {
  return TextStyle(fontSize: 18, color: black);
}

TextStyle textFieldStyle18White() {
  return TextStyle(fontSize: 18, color: white);
}

TextStyle smallButtonStyle() {
  return TextStyle(color: white, fontSize: 12, fontWeight: FontWeight.bold);
}
