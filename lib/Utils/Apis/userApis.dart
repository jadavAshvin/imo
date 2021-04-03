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
Future<http.Response> loginApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      http.Response response =
          await client.post(BASE_URL + LOGIN_URL, body: jsonEncode(body), headers: {"accept": "text/plain", "Content-Type": "application/json"});
      print("Login Response: ${response.request.url}");
      print("Login Response: ${response.body}");
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

Future<http.Response> silentLoginApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      http.Response response =
          await client.post(BASE_URL + SILENT_LOGIN, body: jsonEncode(body), headers: {"accept": "text/plain", "Content-Type": "application/json"});
      print("Silent Login Response: ${response.request.url}");
      print("Silent Login Response: ${response.body}");
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

Future<http.Response> registerApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      http.Response response =
          await client.post(BASE_URL + REGISTER_URL, body: jsonEncode(body), headers: {"accept": "text/plain", "Content-Type": "application/json"});
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

Future<http.Response> updateProfileApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      http.Response response = await client.post(BASE_URL + UPDATE_PROFILE,
          body: jsonEncode(body), headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"});
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

Future<http.Response> confirmSignupApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      http.Response response =
          await client.post(BASE_URL + GET_CODE, body: jsonEncode(body), headers: {"accept": "text/plain", "Content-Type": "application/json"});
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

Future<http.Response> updatePasswordApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      http.Response response =
          await client.post(BASE_URL + GET_CODE, body: jsonEncode(body), headers: {"accept": "text/plain", "Content-Type": "application/json"});
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
