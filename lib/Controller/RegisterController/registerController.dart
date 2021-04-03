import 'dart:convert';

import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Screens/CodeVerification/verificationScreen.dart';
import 'package:flt_imo/Utils/Apis/userApis.dart';
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

  bool validate(flag) {
    if (fullNameController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Full name required');
      return false;
    }
    if (emailController.text.isEmpty && flag == 0) {
      mySnackbar(title: 'Empty', description: 'Email Required');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text) && flag == 0) {
      mySnackbar(title: 'Invalid', description: 'Please enter valid email address');
      return false;
    }
    if (mobileNumberController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Mobile Number required');
      return false;
    }
    if (passwordController.text.isEmpty && flag == 0) {
      mySnackbar(title: 'Empty', description: 'Password required');
      return false;
    }
    if (isChecked.value == false && flag == 0) {
      mySnackbar(title: 'Empty', description: 'Please Agree Terms & Condition');
      return false;
    }
    /* if (passwordController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Select Terms of use');
      return false;
    }*/

    return true;
  }

  registerBtn(flag) {
    if (validate(flag)) {
      if (flag == 0) {
        registerfun();
      } else {
        updateProfilefun();
      }
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

  updateProfilefun() {
    processLoading(true);
    var body = setUpdateProfile();
    print("Update profile $body");
    updateProfileApi(body).then((response) {
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        snackBarBack(title: "Profile Updated Successfull", description: "${res["status"]}").then((rs) {
          processLoading(false);
          Get.back();
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
