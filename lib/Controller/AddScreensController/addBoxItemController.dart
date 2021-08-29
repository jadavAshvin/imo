import 'package:flt_imo/Controller/TabViewController/dashboardController.dart';
import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/Service/itemService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class AddItemController extends GetxController {
  final FocusNode focus = FocusNode();
  var isSaleable = false.obs;
  var isFragile = false.obs;
  var processLoading = false.obs;
  var isNegotiable = false.obs;
  List<dynamic> imageFile = List<dynamic>.empty(growable: true).obs;
  var selectedLocation = Location(name: "Select Location").obs;
  var selectedInventory = Inventory(name: "Select Inventory").obs;
  var selectedBox = Box(title: "Select Box").obs;

  RxInt count = 0.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  clearParam() {
    selectedBox.value = Box(title: "Select Box");
    selectedInventory.value = Inventory(name: "Select Inventory");
    isSaleable.value = false;
    isNegotiable.value = false;
    isFragile.value = false;
    titleController.text = "";
    descriptionController.text = "";
    priceController.text = "";
    count.value = 0;
  }

  setBody() {
    return ({
      "BoxKey": "${selectedBox.value.key}",
      "InventoryId": "${selectedInventory.value.id}",
      "IsSaleable": "${isSaleable.value}",
      "ProjectId": "${AppConstants.PROJECT.id}",
      "Title": "${titleController.text}",
      "IsNegotiable": "${isNegotiable.value}",
      "Description": "${descriptionController.text}",
      "IsFragile": "${isFragile.value}",
      "Price": "${priceController.text}",
      "Quantity": count.value,
    });
  }

  addItem(getAble) {
    processLoading(true);
    var body = setBody();
    ItemService.addItemApi(body).then((response) {
      if (response != null) {
        snackBarBack(title: txtSuccess, description: "Item Added Successfully").then((value) {
          if (getAble) {
            // Get.find<InventoryListController>().getInventoryList(AppConstants.LOCATION_OBJECT.id.toString());
            Get.back();
            Get.find<DashboardController>().getRefreshData();
          }
          // processLoading(false);
        });
        processLoading(false);
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
    // ignore: deprecated_member_use
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    Navigator.pop(context);
    if (image != null) {
      imageFile.add(image);
    }
  }

  Future getImageFromGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    Navigator.pop(context);

    if (image != null) {
      imageFile.add(image);
    }
  }
}
