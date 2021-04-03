import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Models/Inventory/inventoryDetail.dart';
import 'package:flt_imo/Utils/Apis/boxApis.dart';
import 'package:get/get.dart';

class BoxesController extends GetxController {
  var isLoading = true.obs;
  List<Box> boxList = List<Box>.empty(growable: true).obs;
  List<Box> boxListForDisplay = List<Box>.empty(growable: true).obs;

  getBoxesList() async {
    isLoading(true);
    await boxesListApi(getPrefValue(Keys.CUSTOMERID)).then((response) {
      if (response.statusCode == 200) {
        boxList = [];
      }
    });
    isLoading(false);
  }
}
