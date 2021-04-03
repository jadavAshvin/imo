import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Controller/RegisterController/updateProfileController.dart';
import 'package:flt_imo/Screens/Home/Projects/AddLocation/addLocation.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateInventory/CreateInventory.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateNewProject/createProject.dart';
import 'package:flt_imo/Screens/Home/Projects/addBox/addBox.dart';
import 'package:flt_imo/Screens/Home/Projects/myprojects/myprojects.dart';
import 'package:flt_imo/Screens/Home/home.dart';
import 'package:flt_imo/Screens/Login/updatePassword.dart';
import 'package:flt_imo/Screens/UpdateProfile/updateProfile.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Widget/dialog.dart';
import 'package:flt_imo/Widget/imageView.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class DrawerOnly extends StatelessWidget {
  final module;

  const DrawerOnly({Key key, this.module}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        header(context),
        sizer(),
        setLabelView("Dashboard", context, 0, Icons.dashboard),
        sizer(),
        setLabelView("Profile", context, 6, Icons.account_circle),
        sizer(),
        setLabelView("Logout", context, 7, CupertinoIcons.power),
      ],
    ));
  }

  sizer() {
    return SizedBox(
      height: 8,
    );
  }

  Widget header(context) {
    return Container(
        height: Get.height / 4.5,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          color: Colors.green,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              setProfileView(context),
              SizedBox(
                height: 15,
              ),
              Align(
                // alignment: Alignment.bottomLeft,
                child: title_text20BoldWhite(title: "${getPrefValue(Keys.USER_EMAIL)}", context: context),
              ),
            ],
          ),
        ));
  }

  Widget setLabelView(String title, BuildContext context, int flag, icon) {
    return GestureDetector(
      onTap: () {
        switch (flag) {
          case 0:
            Get.off(HomeScreen());
            break;
          case 1:
            Get.to(MyProjects());
            break;
          case 2:
            Get.off(CreateProjects(0, "drawer"));
            break;
          case 3:
            Get.off(CreateInventory(
              flag: 0,
              screen: "drawer",
            ));
            break;
          case 4:
            Get.off(AddLocation(
              0,
              "drawer",
            ));
            break;
          case 5:
            Get.off(AddBoxes(
              flag: 0,
              screen: "drawer",
            ));
            break;
          case 6:
            Get.to(UpdateProfile());
            break;
          case 7:
            logoutDialog();
            break;
          case 8:
            Get.to(UpdatePassword());
            break;
          case 99:
            Get.back();
            break;
          default:
            print('default');
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  height: 50.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        icon,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Text(
                          title,
                          style: textStyleBlack(20),
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              // Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

final updateProfileController = Get.put(UpdateProfileController());
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
