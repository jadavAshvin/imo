import 'dart:convert';
import 'package:flt_imo/Service/constantService.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:http/http.dart' as http;

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
