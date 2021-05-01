import 'package:flt_imo/Controller/LocationController/locationListController.dart';
import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Service/locationService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLocationController extends GetxController {
  final FocusNode focus = FocusNode();
  var processLoading = false.obs;
  var isDetailLoading = false.obs;
  var id;
  TextEditingController enterLocationNameController = TextEditingController();
  TextEditingController enterAddressController = TextEditingController();

  bool validate() {
    if (enterLocationNameController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: txtEnterLocationName);
      return false;
    }
    if (enterAddressController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: txtEnterAddress);
      return false;
    }

    return true;
  }

  addBtn(flag) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addLocation();
        } else {
          updateLocation();
        }
      }
    }
  }

  addLocation() async {
    processLoading(true);
    var body = setBody();

    addLocationApi(body).then((response) {
      if (response == null) {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
      if (response.statusCode == 201) {
        snackBarBack(title: txtSuccess, description: "Location Added Successfully").then((value) {
          Get.back();
          processLoading(false);
        });
      } else {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
    }).catchError((e) {
      printError();
      processLoading(false);
    });
  }

  updateLocation() async {
    processLoading(true);
    var body = setBody();

    updateLocationApi(body, id).then((response) {
      if (response == null) {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: "Location Updated Successfully").then((value) {
          Get.back();
          processLoading(false);
          Get.find<LocationController>().getLocationList();
        });
      } else {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
    }).catchError((e) {
      printError();
      processLoading(false);
    });
  }

  setParam(Location loc) {
    enterAddressController.text = loc.address;
    enterLocationNameController.text = loc.name;
    AppConstants.LAT = loc.latitude.toString();
    AppConstants.LONG = loc.longitude.toString();
    id = loc.id;
  }

  setBody() {
    return ({
      "name": "${enterLocationNameController.text}",
      "address": "${enterAddressController.text}",
      "latitude": double.parse(AppConstants.LAT),
      "longitude": double.parse(AppConstants.LONG),
      "projectId": AppConstants.PROJECT.id
    });
  }
}
