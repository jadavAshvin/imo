import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';

class CreateInventoryController extends GetxController {
  final FocusNode focus = FocusNode();
  var isChecked = false.obs;
  var imageFile = File("").obs;

  TextEditingController enterLocationNameController = TextEditingController();
  TextEditingController enterAddressController = TextEditingController();
}
