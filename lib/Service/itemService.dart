import 'package:flt_imo/Service/constantService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:http/http.dart' as http;

/*---------------------------Boxes Api's-------------------------- */
Future<http.Response> itemListApi() async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    try {
      var response = await client.get(
        BASE_URL + PROJECT + AppConstants.PROJECT.id.toString() + PROJECT_ITEMS,
        headers: {'Authorization': getToken()},
      );
      print("Boxes Item List Response: ${response.request.url}");
      print("Boxes Item List Response: ${response.body}");
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

// ignore: missing_return
Future<http.Response> addItemApi(body) async {
  accessController.checkOnline();
  if (accessController.isOnline.value) {
    var client = http.Client();
    var request = http.MultipartRequest('POST', Uri.parse(BASE_URL + ADD_ITEM));
    var response;
    try {
      // if (uploadFile != null) {
      //   final file = await http.MultipartFile.fromPath("file", uploadFile.path);
      //   request.files.add(file);
      // }
      // request.fields['InventoryId'] = body["InventoryId"];
      request.fields.addAll(body);
      request.headers.addAll({'Authorization': getToken(), "Content-Type": "multipart/form-data"});
      var res = await request.send();
      response = await http.Response.fromStream(res);
      print('Add Item ${res.request.url}');
      print('Add Item ${response.body}');
    } catch (e) {
      print("Item $e");
      return response;
    } finally {
      client.close();
    }
    return response;
  }
}
