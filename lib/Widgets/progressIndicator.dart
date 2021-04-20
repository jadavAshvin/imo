import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget progressIndicator() {
  return Container(
      alignment: Alignment.center,
      height: Get.height / 1.5,
      child: "IMO".text.xl6.ellipsis.makeCentered().shimmer(
            duration: Duration(seconds: 2),
            primaryColor: primaryColor,
            secondaryColor: white,
          ));
}
