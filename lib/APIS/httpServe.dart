import 'dart:convert';

import 'package:flt_imo/APIS/HttpService.dart';
import 'package:flt_imo/APIS/ServiceConstants.dart';
import 'package:flt_imo/Utils/urls.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class HttpServe implements HttpService {
  @override
  Future<Response> getRequest(String url) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      try {
        response = await httpClient.get(Uri.encodeFull(BASE_URL + url), headers: {
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

  @override
  Future<Response> postRequest(String url, body) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      try {
        response = await httpClient.post(Uri.encodeFull(BASE_URL + url), body: jsonEncode(body), headers: {
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

  @override
  Future<Response> patchRequest(String url, body) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      try {
        response = await httpClient.patch(Uri.encodeFull(BASE_URL + url), body: jsonEncode(body), headers: {
          'Authorization': getToken(),
        });
        print("Request: ${response.request!.url} ");
        print("Response: ${response.body}");
        print("Status: ${response.statusCode}");
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

  @override
  Future<Response> putRequest(String url, body) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      try {
        response = await httpClient.put(Uri.encodeFull(BASE_URL + url), body: body, headers: {
          'Authorization': getToken(),
        });
        print("Request: ${response.request!.url} ");
        print("Response: ${response.body}");
        print("Status: ${response.statusCode}");
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

  @override
  Future<Response> deleteRequest(String url) async {
    accessController.checkOnline();
    if (accessController.isOnline.value) {
      GetHttpClient httpClient = GetHttpClient();
      late Response response;
      try {
        response = await httpClient.delete(Uri.encodeFull(BASE_URL + url), headers: {
          'Authorization': getToken(),
        });
        print("Request: ${response.request!.url} ");
        print("Response: ${response.body}");
        print("Status: ${response.statusCode}");
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
}
