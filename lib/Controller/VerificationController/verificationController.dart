import 'dart:convert';

import 'package:flt_imo/Screens/Login/login.dart';
import 'package:flt_imo/Utils/Apis/userApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  TextEditingController pinController = TextEditingController();
  String pin;
  var userId;
  var emailId;
  final FocusNode focus = FocusNode();

  var processLoading = false.obs;
  bool validate() {
    if (pin.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Enter OTP');
      return false;
    }
    return true;
  }

  verifyBtn() {
    if (validate()) {
      verifyOtp();
    }
  }

  verifyOtp() {
    processLoading(true);
    var body = setBody();
    confirmSignupApi(body).then((response) {
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        snackBarBack(title: "User Verified", description: "${res["message"]}").then((r) {
          Get.offAll(Login());
          processLoading(false);
        });
      } else {
        var res = jsonDecode(response.body);
        mySnackbar(title: "Failed", description: "${res["message"]}");
        processLoading(false);
      }
    });
  }

  setBody() {
    return ({"userId": "$userId", "confirmationCode": "${pinController.text}", "emailAddress": "$emailId"});
  }
}
