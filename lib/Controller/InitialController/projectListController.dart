import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Service/projectService.dart';

class MyProjectController extends GetxController {
  var isLoading = true.obs;
  List<Project> project = List<Project>.empty(growable: true).obs;
  List<Project> projectForDisplay = List<Project>.empty(growable: true).obs;

  getProject() async {
    isLoading(true);
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
