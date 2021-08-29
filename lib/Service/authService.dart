import 'package:flt_imo/APIS/HttpService.dart';
import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/APIS/httpServe.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:get/get.dart';

class AuthService {
  static HttpService httpService = HttpServe();
  static Future<Response?> loginApi(body) async {
    Response res = await httpService.postRequest(LOGIN_URL, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else if (res.statusCode == 400) {
      snackBarBack(title: "User Unconfirmed", description: "${res.body["message"]}");
      return res;
    } else {
      snackBarBack(title: "Login Failed", description: "${res.body["message"]}");
      return null;
    }
  }

  static Future<Response?> confirmSignupApi(body) async {
    Response res = await httpService.postRequest(GET_CODE, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> registerApi(body) async {
    Response res = await httpService.postRequest(REGISTER_URL, body).onError((error, stackTrace) => emptyRes);
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
