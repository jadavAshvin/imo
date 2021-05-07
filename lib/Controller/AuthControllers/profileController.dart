import 'dart:io';
import 'package:flt_imo/Models/ProfileModel.dart';
import 'package:flt_imo/Service/userService.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class ProfileController extends GetxController {
  var processLoading = false.obs;
  var isLoading = false.obs;
  var imageFile = File("").obs;
  var gender = txtMale.obs;
  String binaryImage;
  var type;
  var subType;
  ProfileController() {
    getProfile();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  getProfile() async {
    isLoading(true);
    await getUserProfile().then((response) {
      if (response.statusCode == 200) {
        ProfileModel profileModel = profileModelFromJson(response.body);
        setParam(profileModel);
        isLoading(false);
      } else {
        mySnackbar(title: "Failed", description: "Unable to get data");
        isLoading(false);
      }
    });
  }

  bool validate() {
    if (nameController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Full name required');
      return false;
    }
    if (mobileController.text.isEmpty) {
      mySnackbar(title: 'Empty', description: 'Mobile Number required');
      return false;
    }
    return true;
  }

  setParam(ProfileModel profileModel) {
    nameController.text = profileModel.givenName;
    mobileController.text = profileModel.phoneNumber;
    addressController.text = profileModel.address.streetAddress;
    stateController.text = profileModel.address.region;
    countryController.text = profileModel.address.country;
    pinCodeController.text = profileModel.address.postalCode;
    setPrefValue(Keys.REFRESH_TOKEN, profileModel.profilePicture);
  }

  updateProfile() {
    if (validate()) {
      processLoading(true);
      var body = setBody();
      updateProfileApi(body, imageFile.value).then((response) {
        if (response == null) {
          processLoading(false);
        }
        if (response.statusCode == 200) {
          snackBarBack(title: "Updated", description: "Profile Upated Successfully").then((response) {
            processLoading(false);
            getProfile();
          });
        } else {
          mySnackbar(title: "Failed", description: "Unable to Update Profile");
          processLoading(false);
        }
      });
    }
  }

  setBody() {
    return ({
      "GivenName": nameController.text,
      "PhoneNumber": mobileController.text,
      "UserId": getPrefValue(Keys.USER_ID),
      "Gender": gender.value,
      "Address": addressController.text,
      "State": stateController.text,
      "Country": countryController.text,
      "Pincode": pinCodeController.text,
      "AccessToken": getPrefValue(Keys.ACCESS_TOKEN),
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
    var image = await ImagePicker().getImage(source: ImageSource.camera);
    Navigator.pop(context);
    imageFile.value = File(image.path);
  }

  Future getImageFromGallery(BuildContext context) async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    Navigator.pop(context);
    imageFile.value = File(image.path);
  }
}
