import 'dart:convert';
import 'package:flt_imo/Screen/Auth/verificationScreen.dart';
import 'package:flt_imo/Service/userService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FocusNode focus = FocusNode();
  var isChecked = false.obs;
  var processLoading = false.obs;
  var conCode = "+91";
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validate() {
    if (fullNameController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Full name required');
      return false;
    }
    if (emailController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Email Required');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      mySnackbar(title: 'Invalid', description: 'Please enter valid email address');
      return false;
    }
    if (mobileNumberController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Mobile Number required');
      return false;
    }
    if (passwordController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Password required');
      return false;
    }
    if (isChecked.value == false) {
      mySnackbar(title: 'Empty', description: 'Please Agree Terms & Condition');
      return false;
    }
    /* if (passwordController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Select Terms of use');
      return false;
    }*/

    return true;
  }

  registerBtn() {
    if (validate()) {
      registerfun();
    }
  }

  registerfun() {
    processLoading(true);
    var body = setBody();
    registerApi(body).then((response) {
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        snackBarBack(title: "User Registered Successfull", description: "${res["status"]}").then((rs) {
          processLoading(false);
          Get.to(VerificationScreen(
            email: res["emailAddress"],
            userId: res["userId"],
          ));
        });
      } else {
        var res = jsonDecode(response.body);
        snackBarBack(title: "Failed", description: "${res["message"]}").then((r) {
          processLoading(false);
        });
      }
    });
  }

  setBody() {
    return ({
      "emailAddress": "${emailController.text}",
      "password": "${passwordController.text}",
      "givenName": "${fullNameController.text}",
      "phoneNumber": "$conCode${mobileNumberController.text}"
    });
  }

  setUpdateProfile() {
    return ({
      "userId": "${getPrefValue(Keys.USER_ID)}",
      "givenName": "${fullNameController.text}",
      "phoneNumber": "$conCode${mobileNumberController.text}",
      "accessToken": "${getPrefValue(Keys.ACCESS_TOKEN)}"
    });
  }
}
