import 'package:flt_imo/APIS/HttpService.dart';
import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/APIS/httpServe.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class ItemService {
  static HttpService httpService = HttpServe();

  static Future<Response?> itemListApi() async {
    Response res =
        await httpService.getRequest(PROJECT + AppConstants.PROJECT.id.toString() + PROJECT_ITEMS).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> addItemApi(body) async {
    Response res = await addItemApiPost(ADD_ITEM, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 201) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response> addItemApiPost(String url, body) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      try {
        FormData data = FormData(body);
        response = await httpClient.post(Uri.encodeFull(BASE_URL + url), body: data, headers: {
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

  static Future<Response?> updateItemApi(body, id) async {
    Response res = await httpService.putRequest(INVENTORY + id, body).onError((error, stackTrace) => emptyRes);
    if (res.statusCode == 200) {
      return res;
    } else if (res.statusCode == 700) {
      mySnackbar(title: txtFailed, description: txtUnkownError);
      return null;
    } else {
      mySnackbar(title: "Failed", description: "${res.body["message"]}");
    }
  }

  static Future<Response?> deleteItemApi(id) async {
    Response res = await httpService.deleteRequest(INVENTORY + id).onError((error, stackTrace) => emptyRes);
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
