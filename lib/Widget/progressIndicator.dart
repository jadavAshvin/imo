import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget progressIndicator() {
  return Container(
    alignment: Alignment.center,
    height: Get.height / 1.5,
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    ),
  );
}
