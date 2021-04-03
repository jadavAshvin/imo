import 'package:flt_imo/Models/Inventory/inventoryDetail.dart';
import 'package:flt_imo/Utils/Apis/inventoryApis.dart';
import 'package:get/get.dart';

class BoxesListController extends GetxController {
  var isLoading = true.obs;
  List<Box> boxList = List<Box>.filled(0, null).obs;
  List<Box> boxListForDisplay = List<Box>.filled(0, null).obs;

  getboxesList(id) async {
    isLoading(true);
    await inventoryDetailApi(id.toString()).then((response) {
      if (response.statusCode == 200) {
        var b = inventoryDetailFromJson(response.body);
        boxList = b.boxes;
        boxListForDisplay = boxList;
      } else {
        boxList = [];
        boxListForDisplay = boxList;
      }
    });
    isLoading(false);
  }
}
