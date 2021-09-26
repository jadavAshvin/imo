import 'package:flt_imo/Controller/TabViewController/dashboardController.dart';
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
  var isDetailLoading = false.obs;
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
    // if (weightController.text == "") {
    //   mySnackbar(title: txtRequired, description: txtEnterWeight);
    //   return false;
    // }
    // if (heightController.text == "") {
    //   mySnackbar(title: txtRequired, description: txtEnterHeight);
    //   return false;
    // }
    // if (widthController.text == "") {
    //   mySnackbar(title: txtRequired, description: txtEnterWidth);
    //   return false;
    // }
    // if (lenghtController.text == "") {
    //   mySnackbar(title: txtRequired, description: txtEnterLength);
    //   return false;
    // }
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
          addBox(getable);
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

  clearParam() {
    selectedInventory.value = Inventory(name: "Select Inventory");
    selectedLocation.value = Location(name: "Select Location");
    titleController.text = "";
    descriptionController.text = "";
    isSaleable.value = false;
    priceController.text = "";
    isNegotiable.value = false;
    weightController.text = "";
    lenghtController.text = "";
    widthController.text = "";
    heightController.text = "";
  }

  addBox(getAble) async {
    processLoading(true);
    var body = setBody();

    BoxService.addBoxesApi(body).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: "Box Added Successfully").then((value) {
          Get.back();
          Get.find<DashboardController>().getRefreshData();
          processLoading(false);
        });
      }
    }).catchError((e) {
      printError();
      processLoading(false);
    });
  }
}
