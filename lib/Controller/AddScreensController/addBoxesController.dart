import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Service/boxService.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBoxesController extends GetxController {
  final FocusNode focus = FocusNode();

  var isSaleable = false.obs;
  var isFragile = false.obs;
  var isNegotiable = false.obs;
  var processLoading = false.obs;

  var selectedLocation = Location(name: "Select Location").obs;
  var selectedInventory = Inventory(name: "Select Inventory").obs;

  RxInt count = 0.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController lenghtController = TextEditingController();
  //Add Login
  bool validate() {
    if (selectedInventory.value.id == null) {
      mySnackbar(title: txtRequired, description: txtSelectInventory);
      return false;
    }
    if (titleController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterTitle);
      return false;
    }
    if (descriptionController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterDescription);
      return false;
    }
    if (weightController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterWeight);
      return false;
    }
    if (heightController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterHeight);
      return false;
    }
    if (widthController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterWidth);
      return false;
    }
    if (lenghtController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterLength);
      return false;
    }
    if (priceController.text == "") {
      mySnackbar(title: txtRequired, description: txtEnterPrice);
      return false;
    }
    return true;
  }

  addBtn(flag, getable) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addInventory(getable);
        } else {
          Get.back();
        }
      }
    }
  }

  setBody() {
    return ({
      "InventoryId": selectedInventory.value.id,
      "Title": titleController.text,
      "Description": "${descriptionController.text}",
      "UniqueQrCode": "qr.url",
      "IsSaleable": isSaleable.value,
      "Price": double.parse(priceController.text),
      "IsNegotiable": isNegotiable.value,
      "Weight": double.parse(weightController.text),
      "Length": double.parse(lenghtController.text),
      "Width": double.parse(widthController.text),
      "Height": double.parse(heightController.text)
    });
  }

  addInventory(getAble) async {
    processLoading(true);
    var body = setBody();

    addBoxesApi(body).then((response) {
      if (response == null) {
        processLoading(false);
        mySnackbar(title: txtFailed, description: txtUnkownError);
      }
      if (response.statusCode == 201) {
        snackBarBack(title: txtSuccess, description: "Inventory Added Successfully").then((value) {
          Get.back();
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
}
