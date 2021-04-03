import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Controller/ProjectControllers/AddBoxes/addBoxesController.dart';
import 'package:flt_imo/Screens/Drawer/drawer.dart';
import 'package:flt_imo/Screens/Home/Projects/AddLocation/addLocation.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateNewProject/createProject.dart';
import 'package:flt_imo/Widget/GetThings/inventoryDailog.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/material.dart';

import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/appNewbar.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddBoxes extends StatelessWidget {
  final AddBoxesController addBoxesController = Get.put(AddBoxesController());
  final flag;
  final screen;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AddBoxes({Key key, this.flag, this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return screen == "drawer"
        ? Scaffold(
            drawer: DrawerOnly(
              module: "AddBox",
            ),
            key: _scaffoldKey,
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(_scaffoldKey, flag == 0 ? txtAddBoxes : txtViewAndEdit, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: ListView(
              children: [
                // SizedBox(
                //   height: 30,
                // ),
                FifteenSizeBox(),
                project(context),
                locationAndInventoryView(context),
                FifteenSizeBox(),
                Divider(
                  height: 2,
                ),
                textFieldView(context),
                dimensionFieldView(context),
                // quantityView(context),
                // FifteenSizeBox(),
                // setImageView(context),
                priceView(context),
                FifteenSizeBox(),
                makePublickVisibleView(context),
                FifteenSizeBox(),
                Divider(
                  height: 2,
                ),
                setButtons(context),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(null, flag == 0 ? txtAddBoxes : txtViewAndEdit, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: ListView(
              children: [
                FifteenSizeBox(),
                locationAndInventoryView(context),
                FifteenSizeBox(),

                Divider(
                  height: 2,
                ),
                textFieldView(context),
                dimensionFieldView(context),
                // quantityView(context),
                // FifteenSizeBox(),
                // setImageView(context),
                priceView(context),
                FifteenSizeBox(),
                makePublickVisibleView(context),
                FifteenSizeBox(),
                Divider(
                  height: 2,
                ),
                setButtons(context),
              ],
            ),
          );
  }

  Widget setImageView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            flag == 0 ? txtUploadImages : txtUploadedImages,
            style: textFieldStyle20(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 15),
            child: Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    height: 140,
                    child: Obx(() {
                      print("image path is ${addBoxesController.imageFile.value}");
                      return Stack(
                        children: [
                          addBoxesController.imageFile.value.path == ''
                              ? Center(
                                  child: Container(
                                      child: SizedBox(
                                          child: Image.asset(
                                    Images.IMAGE_GALLERY,
                                    height: 50,
                                    width: 50,
                                    color: grey,
                                  ))),
                                )
                              : Image.file(
                                  addBoxesController.imageFile.value,
                                  height: 220,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                        ],
                      );
                    }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        addBoxesController.cameraAction(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        color: Colors.grey[300],
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.camera_alt,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textFieldView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              controller: addBoxesController.titleController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtTitle,
              ),
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
              textInputAction: TextInputAction.next,
            ),
          ),
          TenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              maxLines: null,
              controller: addBoxesController.descriptionController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtDescription,
              ),
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
              textInputAction: TextInputAction.newline,
            ),
          ),
        ],
      ),
    );
  }

  Widget dimensionFieldView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              controller: addBoxesController.weightController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtWeight,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
            ),
          ),
          TenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              controller: addBoxesController.heightController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtHeight,
              ),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
              textInputAction: TextInputAction.next,
            ),
          ),
          TenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              controller: addBoxesController.widthController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtWidth,
              ),
              keyboardType: TextInputType.number,
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
              textInputAction: TextInputAction.next,
            ),
          ),
          TenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.number,
              controller: addBoxesController.lenghtController,
              style: textFieldStyle20(),
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtLength,
              ),
              textInputAction: TextInputAction.newline,
            ),
          ),
          TenSizeBox(),
        ],
      ),
    );
  }

  Widget project(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
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
                child: Text(
                  "Future Gadgets",
                  style: textFieldStyle18(),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(CreateProjects(0, "addboxes"));
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
        ],
      ),
    );
  }

  Widget locationAndInventoryView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (screen != "boxlist")
            Text(
              txtLocation,
              style: textFieldStyle20BoldUnderLine(),
            ),
          if (screen != "boxlist")
            SizedBox(
              height: 5,
            ),
          if (screen != "boxlist")
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Kitchen",
                    style: textFieldStyle18(),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(AddLocation(0, "AddBox"));
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
          if (screen != "boxlist") FifteenSizeBox(),
          Text(
            txtInventory,
            style: textFieldStyle20BoldUnderLine(),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Obx(() => Text(
                      "${addBoxesController.selectedInventory.value.name}",
                      style: textFieldStyle18(),
                    )),
              ),
              InkWell(
                onTap: () async {
                  var pro = await inventoryBottom(AppConstants.LOCATION_OBJECT.id.toString());
                  if (pro != null) {
                    addBoxesController.selectedInventory.value = pro;
                    addBoxesController.update();
                  }
                },
                child: Container(
                  height: 30.0,
                  decoration: boxDecorationWhite(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        txtSelect,
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

  Widget quantityView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            child: Container(
              // decoration: boxDecoration(),
              child: Container(
                child: Text(
                  txtQuantity,
                  style: textFieldStyle20(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Container(
            width: 150,
            height: 40.0,
            decoration: boxDecorationWhite(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addBoxesController.count.value != 0 ? addBoxesController.count.value-- : addBoxesController.count.value;
                  },
                  child: Container(
                    width: 50,
                    height: 38,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: Icon(
                        Icons.minimize_rounded,
                        color: white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Obx(() {
                        return Text(
                          addBoxesController.count.value.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            color: black,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addBoxesController.count.value++;
                  },
                  child: Container(
                    width: 50,
                    height: 38,
                    child: Icon(
                      Icons.add,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            // decoration: boxDecoration(),
            child: TextFormField(
              style: textFieldStyle20(),
              controller: addBoxesController.priceController,
              onFieldSubmitted: (c) => addBoxesController.focus.unfocus(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtPrice,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }

  Widget makePublickVisibleView(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (addBoxesController.isSaleable.value) ? Colors.black : Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        )),
                    width: 22.0,
                    height: 22.0,
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.transparent,
                      ),
                      child: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: addBoxesController.isSaleable.value,
                        tristate: false,
                        onChanged: (bool isChecked) {
                          addBoxesController.isSaleable.value = isChecked;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 10),
                  child: Text(
                    txtisSaleable,
                    style: textFieldStyle20(),
                  ),
                ),
              ],
            ),
            TenSizeBox(),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Padding(
            //       padding: const EdgeInsets.only(top: 5, left: 5),
            //       child: Container(
            //         decoration: BoxDecoration(
            //             border: Border.all(
            //               color: (addBoxesController.isFragile.value) ? Colors.black : Colors.black,
            //               width: 1,
            //             ),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(5),
            //             )),
            //         width: 22.0,
            //         height: 22.0,
            //         child: Theme(
            //           data: ThemeData(
            //             unselectedWidgetColor: Colors.transparent,
            //           ),
            //           child: Checkbox(
            //             activeColor: Colors.black,
            //             checkColor: Colors.white,
            //             value: addBoxesController.isFragile.value,
            //             tristate: false,
            //             onChanged: (bool isChecked) {
            //               addBoxesController.isFragile.value = isChecked;
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.only(top: 3, left: 10),
            //       child: Text(
            //         txtisFragile,
            //         style: textFieldStyle20(),
            //       ),
            //     ),
            //   ],
            // ),
            // TenSizeBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (addBoxesController.isNegotiable.value) ? Colors.black : Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        )),
                    width: 22.0,
                    height: 22.0,
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.transparent,
                      ),
                      child: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: addBoxesController.isNegotiable.value,
                        tristate: false,
                        onChanged: (bool isChecked) {
                          addBoxesController.isNegotiable.value = isChecked;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 10),
                  child: Text(
                    txtisNegotiable,
                    style: textFieldStyle20(),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 100, top: 15),
            //   child: Container(
            //     height: 40.0,
            //     decoration: boxDecorationWhite(),
            //     child: Center(
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 8, right: 8),
            //         child: Text(
            //           txtAddAnotherBox,
            //           style: textFieldStyle18White(),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget setButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 50),
      child: Column(
        children: [
          Obx(
            () => addBoxesController.processLoading.value
                ? CustomButtonProgress(0, 0)
                : CustomButton(
                    txtSave,
                    0,
                    0,
                    () {
                      addBoxesController.addBtn(flag, true);
                    },
                  ),
          ),
          if (flag == 0) TenSizeBox(),
          if (flag == 0) CustomButton(txtSaveAndAddAnotherBox, 0, 0, () {}),
        ],
      ),
    );
  }
}
