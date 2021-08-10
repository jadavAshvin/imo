import 'dart:convert';

import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Service/inventoryService.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryListController extends GetxController {
  var isLoading = true.obs;
  List<Inventory> inventoryList = List<Inventory>.empty(growable: true).obs;
  List<Inventory> inventoryListForDisplay = List<Inventory>.empty(growable: true).obs;
  @override
  void onInit() {
    super.onInit();
  }

  getInventoryList() async {
    isLoading(true);
    await InventoryService.allInventoryApi().then((response) {
      if (response != null) {
        var i = inventoryFromJson(jsonEncode(response.body));
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

  getInventories(id) async {
    isLoading(true);
    await InventoryService.getInventories(id).then((response) {
      if (response != null) {
        var i = inventoryFromJson(jsonEncode(response.body));
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
    InventoryService.deleteInventoryApi(id).then((response) {
      if (response != null) {
        mySnackbar(title: (txtSuccess), description: "Inventory Deleted Successfully");
        getInventoryList();
      }
    });
  }
}
