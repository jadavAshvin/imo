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

/*---------------------------Inventory Api's-------------------------- */
Future<http.Response> inventoryDetailApi(id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + INVENTORY + id,
        headers: {'Authorization': getToken()},
      );
      print("Inventory List Response: ${response.request.url}");
      print("Inventory List Response: ${response.body}");
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

Future<http.Response> addInventoryApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      print("Inventory Req $body");
      var response = await client.post(
        BASE_URL + ADD_INVENTORY,
        headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Inventory Response: ${response.request.url}");
      print("Inventory Response: ${response.body}");
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

Future<http.Response> updateInventoryApi(id, body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.put(
        BASE_URL + INVENTORY + id,
        headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Inventory List Response: ${response.request.url}");
      print("Inventory List Response: ${response.body}");
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

Future<http.Response> deleteInventoryApi(id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.delete(
        BASE_URL + INVENTORY + id,
        headers: {'Authorization': getToken()},
      );
      print("Inventory List Response: ${response.request.url}");
      print("Inventory List Response: ${response.body}");
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
