import 'package:get/get.dart';
import 'package:flt_imo/Controller/Collaborator/shareController.dart';

class CollaboratorController extends GetxController {
  List<Collab> collab = List<Collab>.empty(growable: true).obs;
  List access = ['Read Only', 'Full'];
  var collabIndex = 2.obs;
}
