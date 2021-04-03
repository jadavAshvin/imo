import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final FocusNode focus = FocusNode();
  var processLoading = false.obs;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  setBody() {
    return ({
      "newPassword": "${newPasswordController.text}",
      "currentPassword": "${currentPasswordController.text}",
      "emailAddress": "${getPrefValue(Keys.EMAIL)}"
    });
  }

  updatePassword() {
    processLoading(true);
    var body = setBody();
  }
}
