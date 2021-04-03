import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeController extends GetxController{
  final FocusNode focus = FocusNode();
  var isChecked = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool validate() {

    if (emailController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Enter email address');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      mySnackbar(
          title: 'Invalid', description: 'Please enter valid email address');
      return false;
    }
    if (passwordController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Enter password');
      return false;
    }

    return true;
  }



}