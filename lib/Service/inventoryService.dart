import 'dart:convert';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flt_imo/Service/constantService.dart';
import 'package:flt_imo/Utils/urls.dart';

/*---------------------------Inventory Api's-------------------------- */
Future<http.Response> inventoryDetailApi(id) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + INVENTORY + id.toString(),
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

Future<http.Response> allInventoryApi() async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + PROJECT + AppConstants.PROJECT.id.toString() + PROJECT_INVENTORY,
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
        BASE_URL + INVENTORY + id.toString(),
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
        BASE_URL + INVENTORY + id.toString(),
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
