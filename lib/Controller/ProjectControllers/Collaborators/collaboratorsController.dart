import 'package:flt_imo/Controller/ProjectControllers/Collaborators/sharescreenController.dart';
import 'package:get/get.dart';

class ShareScreenController extends GetxController {
  List<Collab> collab = List<Collab>.empty(growable: true).obs;
  List access = ['Read Only', 'Full'];
  var collabIndex = 2.obs;
}
