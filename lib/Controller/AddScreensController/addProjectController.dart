import 'dart:io';
import 'package:flt_imo/Controller/InitialController/projectListController.dart';
import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Service/projectService.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProjectController extends GetxController {
  final FocusNode focus = FocusNode();
  var isDetailLoading = false.obs;
  var processLoading = false.obs;
  var imageFile = File("").obs;
  late Project project;
  TextEditingController projectNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool validate() {
    if (projectNameController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: txtProjectNameRequired);
      return false;
    }
    return true;
  }

  setBody() {
    return ({"name": "${projectNameController.text}", "description": "${descriptionController.text}"});
  }

  setParam(Project pro) {
    project = pro;
    projectNameController.text = "${pro.name}";
    descriptionController.text = pro.description == "N/A" ? "" : pro.description!;
  }

  addBtn(flag) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addProject();
        } else {
          updateProject();
        }
      }
    }
  }

  addProject() async {
    processLoading(true);
    var body = setBody();
    await ProjectService.addProjectApi(body).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: txtProcjectCreated).then((r) {
          Get.find<MyProjectController>().getProject();

          Get.back();
        });
      }
    });
    processLoading(false);
  }

  updateProject() async {
    processLoading(true);
    var body = setBody();
    await ProjectService.updateProjectApi(body, project.id.toString()).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: txtProcjectCreated).then((r) {
          Get.find<MyProjectController>().getProject();

          Get.back();
        });
      }
    });
    processLoading(false);
  }
}
