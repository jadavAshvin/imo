import 'dart:convert';

import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Controller/accessController.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

String getToken() {
  return "Bearer " + getPrefValue(Keys.AUTH_TOKEN);
}

http.Response emptyRes = http.Response("", 700);
AccessController accessController = Get.find<AccessController>();
/*---------------------------Project Api's-------------------------- */

Future<http.Response> projectListApi() async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + PROJECT,
        headers: {'Authorization': getToken()},
      );
      print("Register Response: ${response.request.url}");
      print("Register Response: ${response.body}");
      return response;
    } catch (e) {
      print(e);
      return emptyRes;
    } finally {
      client.close();
    }
  } else {
    return emptyRes;
  }
}

Future<http.Response> projectDetailApi(id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + PROJECT + id,
        headers: {'Authorization': getToken()},
      );
      print("Project Response: ${response.request.url}");
      print("Project Response: ${response.body}");
      return response;
    } catch (e) {
      print(e);
      return emptyRes;
    } finally {
      client.close();
    }
  } else {
    return emptyRes;
  }
}

Future<http.Response> addProjectApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.post(
        BASE_URL + PROJECT,
        headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Project Response: ${response.request.url}");
      print("Project Response: ${response.body}");
      return response;
    } catch (e) {
      print(e);
      return emptyRes;
    } finally {
      client.close();
    }
  } else {
    return emptyRes;
  }
}

Future<http.Response> updateProjectApi(body, id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.put(
        BASE_URL + PROJECT + id,
        headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Project Response: ${response.request.url}");
      print("Project Response: ${response.body}");
      return response;
    } catch (e) {
      print(e);
      return emptyRes;
    } finally {
      client.close();
    }
  } else {
    return emptyRes;
  }
}

Future<http.Response> deleteProjectApi(id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.delete(
        BASE_URL + PROJECT + id,
        headers: {'Authorization': getToken()},
      );
      print("Project Response: ${response.request.url}");
      print("Project Response: ${response.body}");
      return response;
    } catch (e) {
      print(e);
      return emptyRes;
    } finally {
      client.close();
    }
  } else {
    return emptyRes;
  }
}
