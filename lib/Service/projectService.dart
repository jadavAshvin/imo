import 'package:flt_imo/APIS/HttpService.dart';
import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/APIS/httpServe.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:get/get.dart';

class ProjectService {
  static HttpService httpService = HttpServe();

  static Future<Response?> projectListApi() async {
    Response res = await httpService.getRequest(PROJECT).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> projectDetailApi(id) async {
    Response res = await httpService.getRequest(PROJECT + id.toString()).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> projectStatsApi(id) async {
    Response res = await httpService.getRequest(PROJECT + id.toString() + PROJECT_STATS).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> addProjectApi(body) async {
    Response res = await httpService.postRequest(PROJECT, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 201) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> updateProjectApi(body, id) async {
    Response res = await httpService.putRequest(PROJECT + id, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> deleteProjectApi(id) async {
    Response res = await httpService.deleteRequest(PROJECT + id).onError((error, stackTrace) => emptyRes);
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
