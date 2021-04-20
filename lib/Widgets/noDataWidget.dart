import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget noDataWidget(String title) {
  return Center(
    child: Container(
      height: Get.height / 2.5,
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(
            Images.NO_DATA,
            width: Get.width / 2.5,
            color: Get.theme.primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'No $title Found',
            style: textFieldStyle20(),
          ),
        ]),
      ),
    ),
  );
}
