import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';

// mySnackbar({String title, String description, @required BuildContext context}) {
//   return VxToast.show(context, msg: description);
// }

// Future<bool> snackBarBack({String title, String description}) async {
//   Get.snackbar(title, description, backgroundColor: grey, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
//   bool res = await Future.delayed(Duration(seconds: 2)).then((value) => true);
//   return res;
// }

mySnackbar({required String title, required String description}) {
  return Get.snackbar(title, description, backgroundColor: Colors.green.shade700, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
}

Future<bool> snackBarBack({required String title, required String description}) async {
  Get.snackbar(
    title,
    description,
    backgroundColor: Colors.green.shade700,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    duration: Duration(seconds: 2),
  );
  bool res = await Future.delayed(Duration(seconds: 2)).then((value) => true);
  return res;
}
