import 'dart:convert';

import 'package:flt_imo/Screen/Auth/login.dart';
import 'package:flt_imo/Service/authService.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  TextEditingController pinController = TextEditingController();
  late String pin;
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

  verifyOtp() async {
    processLoading(true);
    var body = setBody();
    await AuthService.confirmSignupApi(body).then((response) {
      if (response != null) {
        var res = jsonDecode(response.body);
        snackBarBack(title: "User Verified", description: "${res["message"]}").then((r) {
          Get.offAll(Login());
        });
      }
    });
    processLoading(false);
  }

  setBody() {
    return ({"userId": "$userId", "confirmationCode": "${pinController.text}", "emailAddress": "$emailId"});
  }
}
