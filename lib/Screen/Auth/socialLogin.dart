import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

socialIcon({press, icon}) {
  return GestureDetector(
    onTap: press,
    child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: primaryColor,
          ),
          shape: BoxShape.circle,
        ),
        child: ImageIcon(
          AssetImage(icon),
          size: 25,
        )),
  );
}

socialLoginOptions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      socialIcon(
        icon: Images.FB,
        press: () {},
      ),
      socialIcon(
        icon: Images.GOOGLE,
        press: () {},
      ),
    ],
  );
}

or() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
    width: Get.width * 0.8,
    child: Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Color(0xFFD9D9D9),
            height: 3.5,
            thickness: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "OR",
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFD9D9D9),
            height: 1.5,
            thickness: 2,
          ),
        ),
      ],
    ),
  );
}
