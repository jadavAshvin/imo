import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:get/get.dart';

class AccessController extends GetxController {
  var isOnline = true.obs;
  @override
  void onInit() {
    super.onInit();
    checkOnline();
  }

  //Online Checker
  void checkOnline() async {
    isOnline(await isConnected());
    update();
  }
}
