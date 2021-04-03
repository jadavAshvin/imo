import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Controller/RegisterController/updateProfileController.dart';
import 'package:flt_imo/Screens/Drawer/drawer.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/appNewbar.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/imageView.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Screens/Login/updatePassword.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      key: _scaffoldKey,
      drawer: DrawerOnly(),
      appBar: PreferredSize(
        child: CustomNewAppBar(_scaffoldKey, txtEditProfile, "", "", null),
        preferredSize: Size.fromHeight(100),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: ListView(
          children: [
            FifteenSizeBox(),
            setProfileView(context),
            FifteenSizeBox(),
            FifteenSizeBox(),
            FifteenSizeBox(),
            registerTextFieldView(context),
            FifteenSizeBox(),
            CustomButton(txtUpdatePasswordWith, 0, 0, () {
              Get.bottomSheet(UpdatePassword());
            }),
          ],
        ),
      ),
    );
  }

  Widget setProfileView(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 110.0,
        height: 110.0,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              maxRadius: 55.0,
              child: Obx(
                () => ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.all(Radius.circular(55.0)),
                  child: updateProfileController.imageFile.value.path == ''
                      ? FadeInImage.assetNetwork(
                          placeholder: Images.MAN,
                          image: updateProfileController.imageFile.value.path,
                          // .replaceAll('\\', '//'),
                          fit: BoxFit.cover,
                          width: 110.0,
                          height: 110.0,
                        )
                      : Image.file(
                          updateProfileController.imageFile.value,
                          fit: BoxFit.cover,
                          width: 110.0,
                          height: 110.0,
                        ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                updateProfileController.cameraAction(context);
              },
              child: Container(
                margin: EdgeInsets.all(3.0),
                alignment: Alignment.bottomRight,
                child: ImageView(Images.IC_IMAGE_CAMERA, 25, 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget registerTextFieldView(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtFirstName,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtLastName,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Gender",
                style: textStyleBlack(20),
              ),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  children: [buildRadio(context, label: txtMale), buildRadio(context, label: txtFemale), buildRadio(context, label: txtTransgender)],
                ),
              ),
            ],
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtMobile,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtAddress,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtState,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtCountry,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        Container(
          child: TextFormField(
            style: textFieldStyle20(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              labelText: txtPin,
              labelStyle: textFieldStyle20(),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        TenSizeBox(),
        SizedBox(
          height: 5,
        ),
        CustomButton(txtUpdateProfile, 0, 0, () {}),
      ],
    );
  }

  Widget setbackButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.only(left: 0, top: 10),
        alignment: Alignment.topLeft,
        height: 50,
        width: 50,
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Row buildRadio(BuildContext context, {@required String label}) {
    return Row(
      children: [
        Radio(
          value: "",
          groupValue: txtMale,
          onChanged: null,
        ),
        Text(
          label,
          textAlign: TextAlign.left,
          style: textStyleBlack(18),
        )
      ],
    );
  }
}
