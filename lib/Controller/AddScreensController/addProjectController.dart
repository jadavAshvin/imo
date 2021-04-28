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
  Project project;
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
    descriptionController.text = pro.description == "N/A" ? "" : pro.description;
  }

  addBtn(flag, getable) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addProject(getable);
        } else {
          updateProject(getable);
        }
      }
    }
  }

  addProject(getable) {
    processLoading(true);
    var body = setBody();
    addProjectApi(body).then((response) {
      if (response.statusCode == 201) {
        snackBarBack(title: txtSuccess, description: txtProcjectCreated).then((r) {
          if (getable) {
            Get.find<MyProjectController>().getProject();
          }
          Get.back();
          processLoading(false);
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        processLoading(false);
      }
    });
  }

  updateProject(getable) {
    processLoading(true);
    var body = setBody();
    updateProjectApi(body, project.id.toString()).then((response) {
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: txtProcjectCreated).then((r) {
          if (getable) {
            Get.find<MyProjectController>().getProject();
          }
          Get.back();
          processLoading(false);
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        processLoading(false);
      }
    });
  }
}
