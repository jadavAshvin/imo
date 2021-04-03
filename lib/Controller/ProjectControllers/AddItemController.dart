import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flt_imo/Utils/Apis/itemApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';

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
      "Description": "${descriptionController.text}",
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
      imageFile.add(croppedFile);
      print("selected file is $croppedFile");
    }
  }
}
