import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Service/userService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final FocusNode focus = FocusNode();
  var processLoading = false.obs;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  bool validate() {
    if (currentPasswordController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: "Please Enter Current Password");
      return false;
    }
    if (newPasswordController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: "Please Enter New Password");
      return false;
    }
    if (confirmNewPasswordController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: "Please Confirm New Password");
      return false;
    }
    if (newPasswordController.text != confirmNewPasswordController.text) {
      mySnackbar(title: txtRequired, description: "New password and confirm password does not match");
      return false;
    }
    return true;
  }

  setBody() {
    return ({
      "newPassword": "${newPasswordController.text}",
      "currentPassword": "${currentPasswordController.text}",
      "emailAddress": getPrefValue(Keys.USER_EMAIL)
    });
  }

  updatePassword() async {
    if (await isConnected()) {
      if (validate()) {
        processLoading(true);
        var body = setBody();
        await updatePasswordApi(body).then((response) {
          if (response.statusCode == 200) {
            mySnackbar(title: txtSuccess, description: "Password Updated");
            processLoading(false);
          } else {
            mySnackbar(title: txtFailed, description: "Cannot update password");
            processLoading(false);
          }
          if (response == null) {
            mySnackbar(title: txtFailed, description: "Cannot update password");
            processLoading(false);
          }
        });
      }
    }
  }
}
