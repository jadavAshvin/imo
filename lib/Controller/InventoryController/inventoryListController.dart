import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Models/locationDetailModel.dart';
import 'package:flt_imo/Service/inventoryService.dart';
import 'package:get/get.dart';

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
}
