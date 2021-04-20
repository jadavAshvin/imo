import 'package:flt_imo/Models/BoxesModel.dart';
import 'package:flt_imo/Service/boxService.dart';
import 'package:get/get.dart';

class BoxesListController extends GetxController {
  var isLoading = true.obs;
  List<Boxes> boxList = List<Boxes>.empty(growable: true).obs;
  List<Boxes> boxListForDisplay = List<Boxes>.empty(growable: true).obs;

  getboxesList() async {
    isLoading(true);
    await boxesListApi().then((response) {
      if (response.statusCode == 200) {
        var b = [];
        boxList = b;
        boxListForDisplay = boxList;
      } else {
        boxList = [];
        boxListForDisplay = boxList;
      }
    });
    isLoading(false);
  }
}
