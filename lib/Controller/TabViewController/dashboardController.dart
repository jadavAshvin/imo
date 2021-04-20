import 'dart:convert';

import 'package:flt_imo/Service/projectService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var piedata = [
    new Task('Location', 0, locationColor),
    new Task('Inventory', 0, inventoryColor),
    new Task('Boxes', 0, boxesColor),
    new Task('Items', 0, itemColor),
  ];
  @override
  void onInit() {
    super.onInit();
    projectStats();
  }

  Future<void> getRefreshData() async {
    projectStats();
  }

  projectStats() async {
    isLoading(true);
    await projectStatsApi(AppConstants.PROJECT.id.toString()).then((response) {
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        piedata[0].taskvalue = res["locationsCount"];
        piedata[1].taskvalue = res["inventoriesCount"];
        piedata[2].taskvalue = res["boxesCount"];
        piedata[3].taskvalue = res["itemsCount"];
      }
    });
    isLoading(false);
  }
}

class Task {
  String task;
  int taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
