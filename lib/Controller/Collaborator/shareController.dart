import 'package:get/get.dart';

class ShareController extends GetxController {
  List<Collab> email = List<Collab>.empty(growable: true).obs;
  List<Collab> mobile = List<Collab>.empty(growable: true).obs;
  List<Collab> contact = List<Collab>.empty(growable: true).obs;
  List access = ['Read Only', 'Full'];
  var emailIndex = 2.obs;
  var mobileIndex = 4.obs;
  var contactIndex = 0.obs;
}

class Collab {
  String entity, access;
  Collab({this.entity, this.access});
}
