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
          Get.back();
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
