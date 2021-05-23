import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Service/inventoryService.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class InventoryListController extends GetxController {
  var isLoading = true.obs;
  List<Inventory> inventoryList = List<Inventory>.empty(growable: true).obs;
  List<Inventory> inventoryListForDisplay = List<Inventory>.empty(growable: true).obs;
  @override
  void onInit() {
    getInventoryList();
    super.onInit();
  }

  getInventoryList() async {
    isLoading(true);
    await allInventoryApi().then((response) {
      if (response.statusCode == 200) {
        var i = inventoryFromJson(response.body);
        inventoryList = i;
        print("Inventory : $inventoryList");
        inventoryListForDisplay = inventoryList;
      } else {
        inventoryList = [];
        inventoryListForDisplay = inventoryList;
      }
    });
    isLoading(false);
  }

  Future<void> getInvRefresh() async {
    getInventoryList();
  }

  deleteInventory(BuildContext context, id) async {
    Future.delayed(Duration(seconds: 1), VxToast.showLoading(context, msg: "Deleting"));
    deleteInventoryApi(id).then((response) {
      if (response == null) {
        mySnackbar(title: txtFailed, description: "Unkown Error Occured");
      }
      if (response.statusCode == 200) {
        mySnackbar(title: txtSuccess, description: "Inventory Deleted Successfully");
        getInventoryList();
      } else {
        mySnackbar(title: txtFailed, description: "Unkown Error Occured");
      }
    });
  }
}
