import 'dart:convert';

import 'package:flt_imo/APIS/HttpService.dart';
import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/APIS/httpServe.dart';
import 'package:flt_imo/Models/ProfileModel.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class UserService {
  static HttpService httpService = HttpServe();

  static Future<Response> updateProfileApi(body) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      FormData formData = FormData(body);
      try {
        response = await httpClient.post(Uri.encodeFull(BASE_URL + UPDATE_PROFILE), body: formData, headers: {
          'Authorization': getToken(),
        });
        print("Request: ${response.request!.url} ");
        print("Response: ${response.body}");
      } on GetHttpException catch (e) {
        print(e.message);
        throw (e.message);
      } finally {
        httpClient.close();
      }
      return response;
    } else {
      return emptyRes;
    }
  }

  static Future<Response?> updatePasswordApi(body) async {
    Response res = await httpService.postRequest(UPDATE_PASSWORD, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> silentLoginApi(body) async {
    Response res = await httpService.postRequest(SILENT_LOGIN, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<ProfileModel?> getProfileApi() async {
    Response res = await httpService.getRequest(GET_PROFILE).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return profileModelFromJson(jsonEncode(res.body));
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: txtUnableData);
      return null;
    }
  }
}
