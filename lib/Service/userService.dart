import 'dart:convert';
import 'dart:io';
import 'package:flt_imo/Service/constantService.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:http/http.dart' as http;

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

Future<http.Response> getUserProfile() async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + GET_PROFILE,
        headers: {'Authorization': getToken()},
      );
      print("User Profile Response: ${response.request.url}");
      print("User Profile Response: ${response.body}");
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

Future<http.Response> updateProfileApi(body, File uploadFile) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    var request = http.MultipartRequest('POST', Uri.parse(BASE_URL + UPDATE_PROFILE));
    http.Response response;
    try {
      print("User Profile Update Body: $body");
      if (uploadFile.path != "") {
        final file = await http.MultipartFile.fromPath("ProfilePhoto", uploadFile.path);
        request.files.add(file);
      }

      request.fields.addAll(body);
      request.headers.addAll({'Authorization': getToken(), "Content-Type": "multipart/form-data", "api-version": "1.0"});
      var res = await request.send();
      response = await http.Response.fromStream(res);
      print('Add Boxes ${res.request.url}');
      print('Add Boxes ${response.body}');
      print('Add Boxes ${response.statusCode}');
      return response;
    } catch (e) {
      print(e);
      return emptyRes;
    } finally {
      client.close();
    }
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
      http.Response response = await client.post(BASE_URL + UPDATE_PASSWORD,
          body: jsonEncode(body), headers: {"accept": "text/plain", "Content-Type": "application/json", "Authorization": getToken()});
      print("Update Pass body: ${jsonEncode(body)}");
      print("Update Pass Response: ${response.request.url}");
      print("Update Pass Response: ${response.body}");
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
