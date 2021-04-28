import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Service/boxService.dart';
import 'package:get/get.dart';

class BoxesListController extends GetxController {
  var isLoading = true.obs;
  List<Box> boxList = List<Box>.empty(growable: true).obs;
  List<Box> boxListForDisplay = List<Box>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
    getboxesList();
  }

  getboxesList() async {
    isLoading(true);
    await boxesListApi().then((response) {
      if (response.statusCode == 200) {
        var b = boxFromJson(response.body);
        boxList = b;
        boxListForDisplay = boxList;
      } else {
        boxList = [];
        boxListForDisplay = boxList;
      }
    });
    isLoading(false);
  }

  Future<void> boxFuture() async {
    getboxesList();
  }
}
