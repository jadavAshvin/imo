import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/Models/projectDetail.dart';
import 'package:flt_imo/Service/locationService.dart';
import 'package:flt_imo/Service/projectService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var isLoading = true.obs;
  ProjectDetail? projectDetail;
  List<Location>? locationList = List<Location>.empty(growable: true).obs;
  List<Location>? locationListForDisplay = List<Location>.empty(growable: true).obs;
  getLocationList() async {
    isLoading(true);
    await ProjectService.projectDetailApi(AppConstants.PROJECT.id).then((response) {
      if (response != null) {
        var l = ProjectDetail.fromJson(response.body);
        projectDetail = l;
        locationList = l.locations;
        locationListForDisplay = locationList;
      } else {
        locationList = [];
        locationListForDisplay = locationList;
      }
    });
    isLoading(false);
  }

  deleteLocation(BuildContext context, id) async {
    // Future.delayed(Duration(seconds: 1), VxToast.showLoading(context, msg: "Deleting").call);
    LocationService.deleteLocationApi(id).then((response) {
      if (response != null) {
        mySnackbar(title: txtSuccess, description: "Location Deleted Successfully");
        getLocationList();
      }
    });
  }

  Future<void> getLocationRefresh() async {
    getLocationList();
  }
}
