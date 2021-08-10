import 'package:get/get.dart';

abstract class HttpService {
  Future<Response> getRequest(String url);
  Future<Response> postRequest(String url, body);
  Future<Response> patchRequest(String url, body);
  Future<Response> putRequest(String url, body);
  Future<Response> deleteRequest(String url);
}
