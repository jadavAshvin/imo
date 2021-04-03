import 'dart:io';
import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Controller/InventoryController/inventoryListController.dart';
import 'package:flt_imo/Models/Location/locationList.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Utils/Apis/boxApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class AddBoxesController extends GetxController {
  final FocusNode focus = FocusNode();
  var isSaleable = false.obs;
  var isFragile = false.obs;
  var isNegotiable = false.obs;
  var processLoading = false.obs;
  var imageFile = File("").obs;
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

  // setBody() {
  //   var b = ({
  //     "InventoryId": selectedInventory.value.id,
  //     "Title": titleController.text,
  //     "Description": descriptionController.text,
  //     "UniqueQrCode": "qr.url",
  //     "IsSaleable": isSaleable.value,
  //     "Price": double.parse(priceController.text),
  //     "IsNegotiable": isNegotiable.value,
  //     "Weight": double.parse(weightController.text),
  //     "Length": double.parse(lenghtController.text),
  //     "Width": double.parse(widthController.text),
  //     "Height": double.parse(heightController.text)
  //   });
  //   return b;
  // }
  setBody() {
    return ({
      "InventoryId": "${selectedInventory.value.id}",
      "Title": "${titleController.text}",
      "Description": "${descriptionController.text}",
      "UniqueQrCode": "qr.url",
      "IsSaleable": isSaleable.value.toString(),
      "Price": priceController.text,
      "IsNegotiable": isNegotiable.value.toString(),
      "Weight": weightController.text,
      "Length": lenghtController.text,
      "Width": widthController.text,
      "Height": heightController.text
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
          if (getAble) {
            Get.find<InventoryListController>().getInventoryList(AppConstants.LOCATION_OBJECT.id.toString());
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

  cameraAction(BuildContext context) {
    final action = CupertinoActionSheet(
      title: Text(
        txtSelectOption,
        style: TextStyle(fontSize: 25),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(txtCamera, style: TextStyle(color: Colors.blue)),
          isDestructiveAction: true,
          onPressed: () {
            getImageFromCamera(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            txtGallery,
            style: TextStyle(color: Colors.blue),
          ),
          isDestructiveAction: true,
          onPressed: () {
            getImageFromGallery(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(txtCancel),
        onPressed: () {
          Get.back();
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  Future getImageFromCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    Get.back();
    showCropView(image);
  }

  Future getImageFromGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    showCropView(image);
  }

  void showCropView(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.ratio3x2,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        aspectRatio: CropAspectRatio(ratioY: 2, ratioX: 3),
        androidUiSettings: AndroidUiSettings(toolbarTitle: 'Cropper', initAspectRatio: CropAspectRatioPreset.square, lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          aspectRatioLockEnabled: true,
        ));

    if (croppedFile != null) {
      imageFile.value = croppedFile;
      update();
      print("selected file is $croppedFile");
    }
  }
}
