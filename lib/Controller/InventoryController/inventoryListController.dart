import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Models/locationDetailModel.dart';
import 'package:flt_imo/Service/inventoryService.dart';
import 'package:flt_imo/Service/locationService.dart';
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
        print("Inventory : $inventoryList");
        inventoryListForDisplay = inventoryList;
      } else {
        inventoryList = [];
        inventoryListForDisplay = inventoryList;
      }
      if (response.statusCode == null) {
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
}

class AllInventoryListController extends GetxController {
  var isLoading = true.obs;
  List<Inventory> inventoryList = List<Inventory>.empty(growable: true);
  List<Inventory> inventoryListForDisplay = List<Inventory>.empty(growable: true);
  @override
  void onInit() {
    super.onInit();
    getInvRefresh();
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
      if (response.statusCode == null) {
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

  Future<void> getInvRefresh() async {
    getInventoryList();
  }
}
