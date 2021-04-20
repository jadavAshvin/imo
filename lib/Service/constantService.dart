import 'package:flt_imo/Controller/GeneralController/accessController.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String getToken() {
  return "Bearer " + getPrefValue(Keys.AUTH_TOKEN);
}

http.Response emptyRes = http.Response("", 700);
AccessController accessController = Get.find<AccessController>();
