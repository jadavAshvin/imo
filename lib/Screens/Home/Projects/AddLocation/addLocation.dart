import 'package:flt_imo/Controller/ProjectControllers/AddLocationController/addLocationController.dart';
import 'package:flt_imo/Screens/Drawer/drawer.dart';
import 'package:flt_imo/Screens/Map/mapScreen.dart';
import 'package:flt_imo/Widget/GetThings/projectDailog.dart';
import 'package:flt_imo/Widget/decoration.dart';

import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';

import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/appNewbar.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Comman/app_constants.dart';

class AddLocation extends StatelessWidget {
  final AddLocationController addLocationController = Get.put(AddLocationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final flag;
  final screen;

  AddLocation(this.flag, this.screen);

  @override
  Widget build(BuildContext context) {
    return screen == "drawer"
        ? Scaffold(
            drawer: DrawerOnly(
              module: "AddLocation",
            ),
            key: _scaffoldKey,
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(_scaffoldKey, txtAddLocation, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  project(context),
                  setTextFieldView(context),
                  FifteenSizeBox(),
                  FifteenSizeBox(),
                  Obx(() => addLocationController.processLoading.value
                      ? CustomButtonProgress(0, 0)
                      : CustomButton(txtAddLocation, 0, 0, () {
                          addLocationController.addBtn(flag);
                        })),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(null, txtAddLocation, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  // project(context),
                  setTextFieldView(context),
                  FifteenSizeBox(),
                  FifteenSizeBox(),
                  Obx(() => addLocationController.processLoading.value
                      ? CustomButtonProgress(0, 0)
                      : CustomButton(txtAddLocation, 0, 0, () {
                          addLocationController.addBtn(flag);
                        })),
                ],
              ),
            ),
          );
  }

  Widget setTextFieldView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //  decoration: boxDecoration(),
            child: TextFormField(
              controller: addLocationController.enterLocationNameController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtEnterLocationName,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                  //  decoration: boxDecoration(),
                  child: TextField(
                    controller: addLocationController.enterAddressController,
                    maxLines: null,
                    style: textFieldStyle20(),
                    //  onEditingComplete: () => loginController.focus.unfocus(),
                    decoration: InputDecoration(
                      //   border: InputBorder.none,
                      hintText: txtLocationAddress,
                    ),
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Get.to(SearchAddress());
                  addLocationController.enterAddressController.text = AppConstants.ADDRESS;
                  addLocationController.latitudeController.text = AppConstants.LAT;
                  addLocationController.longitudeController.text = AppConstants.LONG;
                },
                child: Container(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.my_location,
                      size: 30,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //  decoration: boxDecoration(),
            child: TextFormField(
              controller: addLocationController.latitudeController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtLatitude,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //  decoration: boxDecoration(),
            child: TextFormField(
              controller: addLocationController.longitudeController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtLongitude,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }

  Widget project(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            txtProject,
            style: textFieldStyle20BoldUnderLine(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() => Text(
                      "${addLocationController.selectedProject.value.name}",
                      style: textFieldStyle18(),
                    )),
              ),
              InkWell(
                onTap: () async {
                  var pro = await projectBottom();
                  // print("From File ${pro.name}");
                  if (pro != null) {
                    addLocationController.selectedProject.value = pro;
                    addLocationController.update();
                  }
                },
                child: Container(
                  height: 30.0,
                  decoration: boxDecorationWhite(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        txtChange,
                        style: smallButtonStyle(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
