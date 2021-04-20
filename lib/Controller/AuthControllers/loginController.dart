import 'dart:convert';

import 'package:flt_imo/Models/loginResponseModel.dart';
import 'package:flt_imo/Screen/InitialScreens/projectList.dart';
import 'package:flt_imo/Service/authService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FocusNode focus = FocusNode();
  final FocusNode focusPassword = FocusNode();
  var isChecked = false.obs;
  var processLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool validate() {
    if (emailController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Enter email address');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      mySnackbar(title: 'Invalid', description: 'Please enter valid email address');
      return false;
    }
    if (passwordController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Enter password');
      return false;
    }

    return true;
  }

  loginBtn() {
    if (validate()) {
      loginfun();
    }
  }

  loginfun() async {
    processLoading(true);
    var body = setBody();
    loginApi(body).then((response) {
      if (response.statusCode == 200) {
        // if(l.status == "USER_UNCONFIRMED"){
        // snackBarBack(title: "User Registered Successfull", description: "${l.message}").then((rs) {
        // processLoading(false);
        // Get.to(VerificationScreen(
        //   email: emailController.text,
        //   userId: l.userId,
        // ));
        // }
        var res = jsonDecode(response.body);
        if (res["status"] == "USER_UNCONFIRMED") {
          snackBarBack(title: "User Registered Successfull", description: "${res["message"]}").then((rs) {
            processLoading(false);
            // Get.to(VerificationScreen(
            //   email: emailController.text,
            //   userId: res["userId"],
            // ));
          });
        } else {
          var l = loginResponseFromJson(response.body);
          setPrefValue(Keys.AUTH_TOKEN, l.tokens.idToken.toString());
          setPrefValue(Keys.ACCESS_TOKEN, l.tokens.accessToken.toString());
          setPrefValue(Keys.REFRESH_TOKEN, l.tokens.refreshToken.toString());
          setPrefValue(Keys.USER_ID, l.userId.toString());
          setPrefValue(Keys.USER_EMAIL, l.emailAddress.toString());
          Get.offAll(ProjectListScreen());

          processLoading(false);
        }
      } else {
        var res = jsonDecode(response.body);
        snackBarBack(title: "Login Failed", description: "${res["message"]}").then((v) {
          processLoading(false);
        });
      }
      if (response.statusCode == 200) {
        processLoading(false);
      }
    });
  }

  setBody() {
    return ({"emailAddress": "${emailController.text}", "password": "${passwordController.text}"});
  }
}
