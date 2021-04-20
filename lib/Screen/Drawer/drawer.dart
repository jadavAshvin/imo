import 'package:flt_imo/Screen/Auth/profile.dart';
import 'package:flt_imo/Screen/InitialScreens/projectList.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class DrawerOnly extends StatelessWidget {
  final module;

  const DrawerOnly({Key key, this.module}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1.3,
      height: Get.height * 2,
      color: primaryColor,
      child: Stack(
        children: [
          ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              header(context),
              sizer(),
              // setLabelView("Dashboard", context, 0, Icons.dashboard),
              sizer(),
              setLabelView("All Projects", context, 1, Icons.dashboard),
              sizer(),
              setLabelView("Profile", context, 6, Icons.account_circle),
              sizer(),
              setLabelView("Logout", context, 7, CupertinoIcons.power),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(
          //         Icons.settings,
          //         color: white,
          //       ).pOnly(right: 5),
          //       "Setting".text.xl.white.make(),
          //       Container().w(3).h2(context).backgroundColor(white).px4()
          //     ],
          //   ),
          // ).py16()
        ],
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          switch (flag) {
            case 0:
              // Get.off(HomeScreen());
              break;
            case 1:
              Get.offAll(() => ProjectListScreen());
              break;
            case 2:
              // Get.off(CreateProjects(0, "drawer"));
              break;
            case 3:
              // Get.off(CreateInventory(
              //   flag: 0,
              //   screen: "drawer",
              // ));
              break;
            case 4:
              // Get.off(AddLocation(
              //   0,
              //   "drawer",
              // ));
              break;
            case 5:
              // Get.off(AddBoxes(
              //   flag: 0,
              //   screen: "drawer",
              // ));
              break;
            case 6:
              Get.offAll(() => Profile());
              break;
            case 7:
              logoutDialog();
              break;
            case 8:
              // Get.to(UpdatePassword());
              break;
            case 99:
              Get.back();
              break;
            default:
              print('default');
          }
        },
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
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Text(
                          title,
                          style: textStyleWhite(20),
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: white,
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
            child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.all(Radius.circular(55.0)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.MAN,
                  image: "https://picsum.photos/seed/picsum/200/300",
                  // .replaceAll('\\', '//'),
                  fit: BoxFit.cover,
                  width: 110.0,
                  height: 110.0,
                )),
          ),
        ],
      ),
    ),
  );
}
