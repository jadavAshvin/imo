import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Controller/InventoryController/inventoryListController.dart';
import 'package:flt_imo/Models/Project/projectDetailResponse.dart';
import 'package:flt_imo/Models/Project/projectListResponse.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Utils/Apis/inventoryApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';

class CreateInventoryController extends GetxController {
  var selectedProject = ProjectList(name: "Select Project").obs;
  var selectedLocation = Location(name: "Select Location").obs;
  var locid;
  var upid;
  var processLoading = false.obs;
  var isDetailLoading = false.obs;
  TextEditingController inventoryNameController = TextEditingController();
  bool validateLocaSelect() {
    if (selectedProject.value.id == null) {
      mySnackbar(title: txtRequired, description: txtSelectProject);
      return false;
    }
    return true;
  }

  bool validate() {
    print("From validate ${selectedLocation.value.id}");
    print("From validate Location Name ${selectedLocation.value.name}");
    print("From validate Location bool ${selectedLocation.value.id.toString().isEmpty}");
    if (selectedLocation.value.name == "Select Location") {
      print("From validate Location ${selectedLocation.value.id}");
      mySnackbar(title: txtRequired, description: txtSelectLocation);
      return false;
    }
    if (inventoryNameController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterInventoryName);
      return false;
    }
    return true;
  }

  addBtn(flag, getable) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addInventory(getable);
        } else {
          updateInventory(getable);
        }
      }
    }
  }

  setBody() {
    return ({"name": "${inventoryNameController.text}", "locationId": selectedLocation.value.id});
  }

  addInventory(getable) {
    processLoading(true);
    var body = setBody();
    addInventoryApi(body).then((response) {
      if (response.statusCode == 201) {
        snackBarBack(title: txtSuccess, description: "Inventory Added Successfully").then((v) {
          processLoading(false);
          if (getable) {
            Get.back();
          }
        });
      } else if (response.statusCode == 700) {
        snackBarBack(title: txtFailed, description: txtUnkownError).then((v) {
          processLoading(false);
        });
      } else {
        snackBarBack(title: txtFailed, description: txtUnkownError).then((v) {
          processLoading(false);
        });
      }
    });
  }

  updateInventory(getable) {
    processLoading(true);
    var body = setBody();
    updateInventoryApi(upid.toString(), body).then((response) {
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: "Inventory Updated Successfully").then((v) {
          processLoading(false);
          Get.back();
          Get.find<InventoryListController>().getInventoryList(AppConstants.LOCATION_OBJECT.id.toString());
        });
      } else if (response.statusCode == 700) {
        snackBarBack(title: txtFailed, description: txtUnkownError).then((v) {
          processLoading(false);
        });
      } else {
        snackBarBack(title: txtFailed, description: txtUnkownError).then((v) {
          processLoading(false);
        });
      }
    });
  }
}
