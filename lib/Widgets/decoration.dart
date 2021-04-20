import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/material.dart';

boxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    color: textFieldColor,
  );
}

boxDecorationWhite() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    color: Colors.green,
  );
}

boxDecorationMaterial() {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xff217d7e), Color(0xff217d7e)]));
}

backgroundDecorationMaterial() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xff05404b), Color(0xff1e7779)]));
}
