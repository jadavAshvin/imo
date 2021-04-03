import 'dart:convert';

import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Controller/accessController.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;

String getToken() {
  return "Bearer " + getPrefValue(Keys.AUTH_TOKEN);
}

http.Response emptyRes = http.Response("", 700);
AccessController accessController = Get.find<AccessController>();
var d = dio.Dio();
/*---------------------------Boxes Api's-------------------------- */
// Future<http.Response> boxesListApi(id) async {
//   accessController.checkOnline();
//   if (accessController.isOnline.value) {
//     var client = http.Client();
//     try {
//       var response = await client.get(
//         BASE_URL + BOXES + id,
//         headers: {'Authorization': getToken()},
//       );
//       print("Boxes List Response: ${response.request.url}");
//       print("Boxes List Response: ${response.body}");
//       return response;
//     } catch (e) {
//       print(e);
//       return emptyRes;
//     } finally {
//       client.close();
//     }
//   } else {
//     return emptyRes;
//   }
// }

// Future<http.Response> addBoxesApi(body) async {
//   accessController.checkOnline();
//   if (accessController.isOnline.value) {
//     var client = http.Client();
//     try {
//       print("Inventory Req $body");
//       var response = await client.post(
//         BASE_URL + ADD_BOXES,
//         headers: {'Authorization': getToken(), "accept": "text/plain"},
//         body: jsonEncode(body),
//       );
//       print("Inventory Response: ${response.request.url}");
//       print("Inventory Response: ${response.body}");
//       return response;
//     } catch (e) {
//       print(e);
//       return emptyRes;
//     } finally {
//       client.close();
//     }
//   } else {
//     return emptyRes;
//   }
// }

// Future<http.Response> updateBoxesApi(id, body) async {
//   accessController.checkOnline();
//   if (accessController.isOnline.value) {
//     var client = http.Client();
//     try {
//       var response = await client.put(
//         BASE_URL + BOXES + id,
//         headers: {'Authorization': getToken(), "accept": "text/plain", "Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );
//       print("Inventory List Response: ${response.request.url}");
//       print("Inventory List Response: ${response.body}");
//       return response;
//     } catch (e) {
//       print(e);
//       return emptyRes;
//     } finally {
//       client.close();
//     }
//   } else {
//     return emptyRes;
//   }
// }

// // ignore: missing_return
// Future<http.Response> addBoxesApi(body) async {
//   accessController.checkOnline();
//   if (accessController.isOnline.value) {
//     var client = http.Client();
//     var request = http.MultipartRequest('POST', Uri.parse(BASE_URL + ADD_BOXES));
//     var response;
//     try {
//       // if (uploadFile != null) {
//       //   final file = await http.MultipartFile.fromPath("file", uploadFile.path);
//       //   request.files.add(file);
//       // }
//       // request.fields['InventoryId'] = body["InventoryId"];
//       request.fields.addAll(body);
//       request.headers.addAll({'Authorization': getToken(), "Content-Type": "multipart/form-data"});
//       var res = await request.send();
//       response = await http.Response.fromStream(res);
//       print('Add Boxes ${res.request.url}');
//       print('Add Boxes ${response.body}');
//     } catch (e) {
//       print("Box $e");
//       return response;
//     } finally {
//       client.close();
//     }
//     return response;
//   }
// }

// ignore: missing_return
Future<dio.Response> addItemApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    // dio.FormData formData = new dio.FormData.fromMap(body);
    print(body);
    try {
      const _extra = <String, dynamic>{};

      final _result = await d.request<Map<String, dynamic>>(ITEM,
          options: dio.RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{
                'Authorization': getToken(),
                "accept": "text/plain",
                "Content-Type": "multipart/form-data",
              },
              extra: _extra,
              baseUrl: BASE_URL),
          data: body);
      print('Add Boxes ${_result.request.path}');
      print('Add Boxes ${_result.data}');
      return _result;
    } on dio.DioError catch (e) {
      print(e);
    }
  }
}
