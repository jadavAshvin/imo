import 'package:flt_imo/Service/constantService.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*---------------------------Location Api's-------------------------- */
Future<http.Response> locationDetailApi(id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + LOCATION + id.toString(),
        headers: {'Authorization': getToken()},
      );
      print("Location List Response: ${response.request.url}");
      print("Location List Response: ${response.body}");
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

Future<http.Response> addLocationApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      print("Location Req $body");
      var response = await client.post(
        BASE_URL + ADD_LOCATION,
        headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Add Location Response: ${response.request.url}");
      print("Add Location Response: ${response.body}");
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
