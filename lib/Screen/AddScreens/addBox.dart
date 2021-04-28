import 'package:flt_imo/Controller/AddScreensController/addBoxesController.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/decorationConstant.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/GetThings/inventoryDailog.dart';
import 'package:flt_imo/Widgets/GetThings/locationDailog.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBox extends StatelessWidget {
  final flag;
  final AddBoxesController addBoxesController = Get.put(AddBoxesController());

  AddBox({Key key, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  Widget locationAndInventoryView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
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
                      "${addBoxesController.selectedLocation.value.name}",
                      style: textFieldStyle18(),
                    )),
              ),
              InkWell(
                onTap: () async {
                  var loc = await locationBottom(AppConstants.PROJECT.id.toString());
                  if (loc != null) {
                    addBoxesController.selectedLocation.value = loc;
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
          FifteenSizeBox(),
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
                  var pro = await inventoryBottom(addBoxesController.selectedLocation.value.id.toString());
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
                labelText: txtTitle,
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
                labelText: txtDescription,
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
                labelText: txtWeight,
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
                labelText: txtHeight,
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
                labelText: txtWidth,
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
              keyboardType: TextInputType.number,
              controller: addBoxesController.lenghtController,
              style: textFieldStyle20(),
              onFieldSubmitted: (c) => addBoxesController.focus.nextFocus(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                labelText: txtLength,
              ),
              textInputAction: TextInputAction.newline,
            ),
          ),
          TenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              style: textFieldStyle20(),
              controller: addBoxesController.priceController,
              onFieldSubmitted: (c) => addBoxesController.focus.unfocus(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                labelText: txtPrice,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
          ),
          TenSizeBox(),
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

  // Widget priceView(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 25, right: 25),
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
  //           // decoration: boxDecoration(),
  //           child: TextFormField(
  //             style: textFieldStyle20(),
  //             controller: addBoxesController.priceController,
  //             onFieldSubmitted: (c) => addBoxesController.focus.unfocus(),
  //             //  onEditingComplete: () => loginController.focus.unfocus(),
  //             decoration: InputDecoration(
  //               //  border: InputBorder.none,
  //               labelText: txtPrice,
  //             ),
  //             keyboardType: TextInputType.number,
  //             textInputAction: TextInputAction.next,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
