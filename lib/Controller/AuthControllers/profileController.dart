import 'dart:io';
import 'package:flt_imo/Utils/strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class ProfileController extends GetxController {
  var processLoading = false.obs;
  var isDetailLoading = false.obs;
  var imageFile = File("").obs;

  var gender = txtMale.obs;

  getProfile() {}
  //Camera Actions
  cameraAction(BuildContext context) {
    showAdaptiveActionSheet(
      title: Text(
        txtSelectOption,
        style: TextStyle(fontSize: 25),
      ),
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Text(txtCamera, style: TextStyle(color: Colors.blue)),
          onPressed: () {
            getImageFromCamera(context);
          },
        ),
        BottomSheetAction(
          title: Text(
            txtGallery,
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            getImageFromGallery(context);
          },
        )
      ],
      cancelAction: CancelAction(
        title: Text(txtCancel),
        onPressed: () {
          Get.back();
        },
      ),
      context: context,
    );
    // showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Future getImageFromCamera(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    imageFile.value = image;
  }

  Future getImageFromGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    imageFile.value = image;
  }
}
