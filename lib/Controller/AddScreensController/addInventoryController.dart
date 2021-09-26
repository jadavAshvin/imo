import 'package:flt_imo/Controller/InventoryController/inventoryListController.dart';
import 'package:flt_imo/Controller/TabViewController/dashboardController.dart';
import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Service/inventoryService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/strings.dart';

class CreateInventoryController extends GetxController {
  var selectedLocation = Location(name: "Select Location").obs;
  var locid;
  var upid;
  var processLoading = false.obs;
  var isDetailLoading = false.obs;
  TextEditingController inventoryNameController = TextEditingController();

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

  addBtn(flag) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addInventory();
        } else {
          updateInventory();
        }
      }
    }
  }

  setParam(Inventory inventory) {
    inventoryNameController.text = inventory.name!;
    selectedLocation.value = Location(id: inventory.locationId);
    upid = inventory.id;
  }

  setBody() {
    return ({"name": "${inventoryNameController.text}", "locationId": selectedLocation.value.id, "projectId": AppConstants.PROJECT.id});
  }

  addInventory() async {
    processLoading(true);
    var body = setBody();
    await InventoryService.addInventoryApi(body).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: "Inventory Added Successfully").then((v) {
          processLoading(false);
          Get.find<DashboardController>().getRefreshData();
          Get.back();
        });
      }
    });
  }

  updateInventory() {
    processLoading(true);
    var body = setBody();
    InventoryService.updateInventoryApi(upid.toString(), body).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: "Inventory Updated Successfully").then((v) {
          processLoading(false);
          Get.back();

          Get.find<InventoryListController>().getInventoryList();
        });
      }
    });
  }
}
