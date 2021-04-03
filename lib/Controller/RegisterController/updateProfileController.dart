import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flt_imo/Controller/ProjectControllers/MyProjectController/myProcjectController.dart';
import 'package:flt_imo/Models/Project/projectListResponse.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Utils/Apis/projectApis.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class UpdateProfileController extends GetxController {
  final FocusNode focus = FocusNode();
  var isDetailLoading = false.obs;
  var processLoading = false.obs;
  var imageFile = File("").obs;
  ProjectList project;
  TextEditingController projectNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool validate() {
    if (projectNameController.text.isEmpty) {
      mySnackbar(title: txtRequired, description: txtProjectNameRequired);
      return false;
    }
    return true;
  }

  setBody() {
    return ({"name": "${projectNameController.text}"});
  }

  setParam(ProjectList pro) {
    project = pro;
    projectNameController.text = "${pro.name}";
  }

  addBtn(flag, getable) async {
    if (await isConnected()) {
      if (validate()) {
        if (flag == 0) {
          addProject(getable);
        } else {
          updateProject(getable);
        }
      }
    }
  }

  addProject(getable) {
    processLoading(true);
    var body = setBody();
    addProjectApi(body).then((response) {
      if (response.statusCode == 201) {
        snackBarBack(title: txtSuccess, description: txtProcjectCreated).then((r) {
          if (getable) {
            Get.find<MyProjectController>().getProjectList();
          }
          Get.back();
          processLoading(false);
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        processLoading(false);
      }
    });
  }

  updateProject(getable) {
    processLoading(true);
    var body = setBody();
    updateProjectApi(body, project.id.toString()).then((response) {
      if (response.statusCode == 200) {
        snackBarBack(title: txtSuccess, description: txtProcjectCreated).then((r) {
          if (getable) {
            Get.find<MyProjectController>().getProjectList();
          }
          Get.back();
          processLoading(false);
        });
      } else {
        mySnackbar(title: txtFailed, description: "");
        processLoading(false);
      }
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
    Get.back();
    // showCropView(image);
  }

  Future getImageFromGallery(BuildContext context) async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    Navigator.pop(context);
    showCropView(image);
  }

  void showCropView(PickedFile image) async {
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
