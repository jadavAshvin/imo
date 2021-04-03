import 'package:flt_imo/Models/Location/locationList.dart';
import 'package:flt_imo/Utils/Apis/inventoryApis.dart';
import 'package:flt_imo/Utils/Apis/locationApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryListController extends GetxController {
  var isLoading = true.obs;
  List<Inventory> inventoryList = List<Inventory>.empty(growable: true).obs;
  List<Inventory> inventoryListForDisplay = List<Inventory>.empty(growable: true).obs;
  getInventoryList(id) async {
    isLoading(true);
    await locationDetailApi(id).then((response) {
      if (response.statusCode == 200) {
        var i = locationListFromJson(response.body);
        inventoryList = i.inventories;
        inventoryListForDisplay = inventoryList;
      } else if (response.statusCode == null) {
        inventoryList = [];
        inventoryListForDisplay = inventoryList;
      } else if (response.statusCode == 700) {
        inventoryList = [];
        inventoryListForDisplay = inventoryList;
      } else {
        inventoryList = [];
        inventoryListForDisplay = inventoryList;
      }
    });
    isLoading(false);
  }

  deleteInventory(deleteid, id) {
    Get.back();
    Get.defaultDialog(title: "Deleting", content: Center(child: CircularProgressIndicator()), barrierDismissible: false);
    deleteInventoryApi(deleteid).then((response) {
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: "Imventory deleted Successfully").then((r) {
          Get.back();
          getInventoryList(id);
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        Get.back();
      }
    });
  }
}
