import 'package:flt_imo/Models/Boxes/boxesDetail.dart';
import 'package:flt_imo/Utils/Apis/boxApis.dart';
import 'package:get/get.dart';

class BoxesItemController extends GetxController {
  var isLoading = true.obs;
  List<Item> itemList = List<Item>.empty(growable: true).obs;
  List<Item> itemListForDisplay = List<Item>.empty(growable: true).obs;

  getItemList(id) async {
    isLoading(true);
    await boxesListApi(id).then((response) {
      if (response.statusCode == 200) {
        var i = boxDetailFromJson(response.body);
        itemList = i.items;
        itemListForDisplay = itemList;
      } else {
        itemList = [];
        itemListForDisplay = itemList;
      }
    });
    isLoading(false);
  }
}
