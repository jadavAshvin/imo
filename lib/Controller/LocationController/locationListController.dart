import 'dart:convert';
import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/Models/projectDetail.dart';
import 'package:flt_imo/Service/projectService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var isLoading = true.obs;
  ProjectDetail projectDetail;
  List<Location> locationList = List<Location>.empty(growable: true).obs;
  List<Location> locationListForDisplay = List<Location>.empty(growable: true).obs;
  getLocationList() async {
    isLoading(true);
    await projectDetailApi(AppConstants.PROJECT.id).then((response) {
      if (response.statusCode == 200) {
        var l = projectDetailFromJson(response.body);
        projectDetail = l;
        locationList = l.locations;
        locationListForDisplay = locationList;
      } else {
        locationList = [];
        locationListForDisplay = locationList;
        var res = jsonDecode(response.body);
        mySnackbar(title: txtFailed, description: "${res["message"]}");
      }
    });
    isLoading(false);
  }

  Future<void> getLocationRefresh() async {
    getLocationList();
  }
}
