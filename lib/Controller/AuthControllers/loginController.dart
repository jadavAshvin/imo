import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/Bindings/ProfileBinding.dart';
import 'package:flt_imo/Models/loginResponseModel.dart';
import 'package:flt_imo/Screen/Auth/verificationScreen.dart';
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
    var response = await AuthService.loginApi(body).onError((error, stackTrace) => emptyRes);

    if (response != null) {
      var res = response.body;
      if (res["status"] == "USER_UNCONFIRMED") {
        snackBarBack(title: "User Registered Successfull", description: "${res["message"]}").then((rs) {
          Get.off(VerificationScreen(
            email: emailController.text,
            userId: res["userId"],
          ));
        });
      } else {
        var l = LoginResponse.fromJson(response.body);
        setPrefValue(Keys.AUTH_TOKEN, l.tokens!.idToken.toString());
        setPrefValue(Keys.ACCESS_TOKEN, l.tokens!.accessToken.toString());
        setPrefValue(Keys.REFRESH_TOKEN, l.tokens!.refreshToken.toString());
        setPrefValue(Keys.USER_ID, l.userId.toString());
        setPrefValue(Keys.USER_EMAIL, l.emailAddress.toString());
        Get.offAll(ProjectListScreen(), binding: ProfileBinding());
      }
    }
    processLoading(false);
  }

  setBody() {
    return ({"emailAddress": "${emailController.text}", "password": "${passwordController.text}"});
  }
}
