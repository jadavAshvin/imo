import 'dart:io';
import 'package:flt_imo/Service/itemService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class AddItemController extends GetxController {
  final FocusNode focus = FocusNode();
  var isSaleable = false.obs;
  var isFragile = false.obs;
  var processLoading = false.obs;
  var isNegotiable = false.obs;
  List<dynamic> imageFile = List<dynamic>().obs;

  RxInt count = 0.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  setBody() {
    return ({
      "BoxKey": "${descriptionController.text}",
      "IsSaleable": "${isSaleable.value}",
      "Price": "${priceController.text}",
      "IsNegotiable": "${isNegotiable.value}",
      "IsFragile": "${isFragile.value}",
      "Quantity": "${quantityController.text}",
    });
  }

  addItem(getAble) {
    var body;
    addItemApi(body).then((response) {
      if (response == null) {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
      if (response.statusCode == 201) {
        snackBarBack(title: txtSuccess, description: "Item Added Successfully").then((value) {
          if (getAble) {
            // Get.find<InventoryListController>().getInventoryList(AppConstants.LOCATION_OBJECT.id.toString());
            Get.back();
          }
          processLoading(false);
        });
      } else {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
    }).catchError((e) {
      printError();
      processLoading(false);
    });
  }

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
    if (image != null) {
      imageFile.add(image);
    }
  }

  Future getImageFromGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);

    if (image != null) {
      imageFile.add(image);
    }
  }
}
