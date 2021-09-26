import 'package:flt_imo/APIS/HttpService.dart';
import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/APIS/httpServe.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:get/get.dart';

class LocationService {
  static HttpService httpService = HttpServe();

  static Future<Response?> locationDetailApi(id) async {
    Response res = await httpService.getRequest(LOCATION + id.toString()).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> addLocationApi(body) async {
    Response res = await httpService.postRequest(ADD_LOCATION, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 201) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> updateLocationApi(body, id) async {
    Response res = await httpService.putRequest(LOCATION + id, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> deleteLocationApi(id) async {
    Response res = await httpService.deleteRequest(LOCATION + id.toString()).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }
}
