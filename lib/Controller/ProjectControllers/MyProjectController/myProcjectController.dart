import 'package:flt_imo/Models/Project/projectListResponse.dart';
import 'package:flt_imo/Utils/Apis/projectApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';

class MyProjectController extends GetxController {
  var isLoading = true.obs;
  List<ProjectList> projectList = List<ProjectList>.empty(growable: true).obs;
  List<ProjectList> projectListForDisplay = List<ProjectList>.empty(growable: true).obs;

  getProjectList() async {
    isLoading(true);
    await projectListApi().then((response) {
      if (response.statusCode == 200) {
        projectList = projectListFromJson(response.body);
        projectListForDisplay = projectList;
      } else {
        projectList = [];
        projectListForDisplay = projectList;
      }
    });
    isLoading(false);
  }

  deleteProject(deleteid) {
    Get.back();
    Get.defaultDialog(title: "Deleting", content: Center(child: CircularProgressIndicator()), barrierDismissible: false);
    deleteProjectApi(deleteid).then((response) {
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: "Imventory deleted Successfully").then((r) {
          Get.back();
          getProjectList();
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        Get.back();
      }
    });
  }
}
