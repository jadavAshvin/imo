import 'package:flt_imo/Models/boxItemModel.dart';
import 'package:flt_imo/Service/itemService.dart';
import 'package:get/get.dart';

class BoxesItemController extends GetxController {
  var isLoading = true.obs;
  List<BoxItem> itemList = List<BoxItem>.empty(growable: true).obs;
  List<BoxItem> itemListForDisplay = List<BoxItem>.empty(growable: true).obs;

  getItemList() async {
    isLoading(true);
    await itemListApi().then((response) {
      if (response.statusCode == 200) {
        var i = boxItemFromJson(response.body);
        itemList = i;
        itemListForDisplay = itemList;
      } else {
        itemList = [];
        itemListForDisplay = itemList;
      }
    });
    isLoading(false);
  }
}
