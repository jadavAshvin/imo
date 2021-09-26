import 'package:flt_imo/Controller/GeneralController/accessController.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:get/get.dart';

String getToken() {
  return "Bearer " + getPrefValue(Keys.AUTH_TOKEN);
}

Response emptyRes = Response(body: "", statusCode: 700);
AccessController accessController = Get.find<AccessController>();
