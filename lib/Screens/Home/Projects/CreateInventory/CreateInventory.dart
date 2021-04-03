import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Controller/CreateInventoryController/createInventoryController.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Screens/Drawer/drawer.dart';
import 'package:flt_imo/Widget/GetThings/locationDailog.dart';
import 'package:flt_imo/Widget/GetThings/projectDailog.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';

import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/appNewbar.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateInventory extends StatelessWidget {
  final CreateInventoryController inventoryController = Get.put(CreateInventoryController());
  final screen;
  final flag;
  final inv;
  final invid;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CreateInventory({Key key, this.screen, this.flag, this.inv, this.invid}) : super(key: key);
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
              child: CustomNewAppBar(_scaffoldKey, flag == 1 ? txtEditInventory : txtCreateInventory, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  project(context),
                  setTextFieldView(context),
                  FifteenSizeBox(),
                  Obx(() => inventoryController.processLoading.value
                      ? CustomButtonProgress(0, 0)
                      : CustomButton(txtCreate, 0, 0, () {
                          print("Add Btn ${inventoryController.locid}");
                          inventoryController.addBtn(flag, false);
                        })),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(null, flag == 1 ? txtEditInventory : txtCreateInventory, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: GetX<CreateInventoryController>(
                init: CreateInventoryController(),
                initState: (_) {
                  if (flag == 1) {
                    inventoryController.selectedLocation.value = AppConstants.LOCATION_OBJECT;
                    inventoryController.inventoryNameController.text = inv;
                    inventoryController.upid = invid;
                  }
                },
                builder: (_) {
                  return _.isDetailLoading.value
                      ? progressIndicator()
                      : ListView(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            setTextFieldView(context),
                            FifteenSizeBox(),
                            Obx(() => inventoryController.processLoading.value
                                ? CustomButtonProgress(0, 0)
                                : CustomButton(flag == 1 ? txtupdate : txtCreate, 0, 0, () {
                                    print("Add Btn ${inventoryController.locid}");
                                    inventoryController.addBtn(flag, screen == "inventorylist" ? true : false);
                                  })),
                          ],
                        );
                },
              ),
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
                      "${inventoryController.selectedProject.value.name}",
                      style: textFieldStyle18(),
                    )),
              ),
              InkWell(
                onTap: () async {
                  var pro = await projectBottom();
                  // print("From File ${pro.name}");
                  if (pro != null) {
                    inventoryController.selectedProject.value = pro;
                    inventoryController.update();
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

  Widget setTextFieldView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txtLocation,
            style: textFieldStyle20BoldUnderLine(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() => Text(
                      "${inventoryController.selectedLocation.value.name}",
                      style: textFieldStyle18(),
                    )),
              ),
              InkWell(
                onTap: () async {
                  if (await isConnected()) {
                    if (screen == "drawer") {
                      if (inventoryController.validateLocaSelect()) {
                        var loc = await locationBottom(inventoryController.selectedProject.value.id.toString());
                        if (loc != null) {
                          inventoryController.selectedLocation.value = loc;
                          inventoryController.locid = loc.id;
                          print("Loc id: ${inventoryController.selectedLocation.value.id}");
                          inventoryController.update();
                        }
                      }
                    } else {
                      var loc = await locationDailog(AppConstants.PROJECT_ID);
                      if (loc != null) {
                        inventoryController.selectedLocation.value = loc;
                        inventoryController.update();
                      }
                    }
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
          FifteenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              style: textFieldStyle20(),
              controller: inventoryController.inventoryNameController,
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtInventoryName,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
