import 'package:flt_imo/Controller/AuthControllers/profileController.dart';
import 'package:flt_imo/Screen/Auth/updatePassword.dart';
import 'package:flt_imo/Screen/Drawer/drawer.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/imageView.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({Key key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ProfileController updateProfileController = Get.put(ProfileController());
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

  buildRadio(BuildContext context, {@required String label}) {
    return Obx(() => Row(
          children: [
            Radio(
              activeColor: primaryColor,
              value: label,
              groupValue: updateProfileController.gender.value,
              onChanged: (value) {
                updateProfileController.gender.value = value;
              },
            ),
            Text(
              label,
              textAlign: TextAlign.left,
              style: textStyleBlack(18),
            )
          ],
        ));
  }
}
