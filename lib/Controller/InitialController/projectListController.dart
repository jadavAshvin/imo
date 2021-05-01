import 'package:flt_imo/Models/loginResponseModel.dart';
import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Screen/Auth/login.dart';
import 'package:flt_imo/Service/userService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Service/projectService.dart';
import 'dart:async';

class MyProjectController extends GetxController {
  var isLoading = true.obs;
  List<Project> project = List<Project>.empty(growable: true).obs;
  List<Project> projectForDisplay = List<Project>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(seconds: 3480), (Timer t) => silentLogin());
  }

  silentLogin() {
    if (getPrefValue(Keys.REFRESH_TOKEN) != "") {
      var body = {"userId": getPrefValue(Keys.USER_ID), "refreshToken": getPrefValue(Keys.REFRESH_TOKEN)};
      silentLoginApi(body).then((response) {
        if (response.statusCode == 200) {
          var l = loginResponseFromJson(response.body);
          setPrefValue(Keys.AUTH_TOKEN, l.tokens.idToken.toString());
          setPrefValue(Keys.ACCESS_TOKEN, l.tokens.accessToken.toString());
          // setPrefValue(Keys.REFRESH_TOKEN, l.tokens.refreshToken.toString());
          setPrefValue(Keys.USER_ID, l.userId.toString());
        } else {
          setPrefValue(Keys.AUTH_TOKEN, "");
          setPrefValue(Keys.ACCESS_TOKEN, "");
          setPrefValue(Keys.REFRESH_TOKEN, "");
          Get.offAll(Login());
        }
      });
    } else {
      print("user is logout");
    }
  }

  getProject() async {
    isLoading(true);
    await silentLogin();
    await projectListApi().then((response) {
      if (response.statusCode == 200) {
        project = projectFromJson(response.body);
        projectForDisplay = project;
      } else {
        project = [];
        projectForDisplay = project;
      }
    });
    isLoading(false);
  }

  Future<void> getRefreshData() async {
    getProject();
  }

  deleteProject(deleteid) {
    Get.back();
    Get.defaultDialog(title: "Deleting", content: Center(child: CircularProgressIndicator()), barrierDismissible: false);
    deleteProjectApi(deleteid).then((response) {
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: "Project deleted Successfully").then((r) {
          Get.back();
          getProject();
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        Get.back();
      }
    });
  }
}
