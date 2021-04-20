import 'package:flt_imo/Controller/AddScreensController/addBoxItemController.dart';
import 'package:flt_imo/Utils/decorationConstant.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddBoxItem extends StatelessWidget {
  final AddItemController addBoxesController = Get.put(AddItemController());
  final flag;

  AddBoxItem({Key key, this.flag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        child: CustomNewAppBar(null, flag == 0 ? txtAddItem : txtEditItem, "", "", () {}),
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
          FifteenSizeBox(),
          quantityView(context),
          FifteenSizeBox(),
          secondImage(context),
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
                    child: Stack(
                      children: [
                        addBoxesController.imageFile[0].path == ''
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
                                addBoxesController.imageFile[0].path,
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                      ],
                    ),
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

  Widget secondImage(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 21, right: 21),
        child: Obx(() {
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1,
            children: List.generate(addBoxesController.imageFile.length + 1, (index) {
              var currentIndex = index + 1;
              if (currentIndex == addBoxesController.imageFile.length + 1) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      addBoxesController.cameraAction(context);
                    },
                  ),
                );
              }
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Image.file(
                      addBoxesController.imageFile[index],
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        child: Icon(
                          Icons.remove_circle,
                          size: 20,
                          color: Colors.red,
                        ),
                        onTap: () {
                          addBoxesController.imageFile.removeAt(index);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        }));
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
              textInputAction: TextInputAction.next,
            ),
          ),
          TenSizeBox(),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            //decoration: boxDecoration(),
            child: TextFormField(
              maxLines: null,
              controller: addBoxesController.priceController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                // border: InputBorder.none,
                hintText: txtDescription,
              ),
              textInputAction: TextInputAction.newline,
            ),
          ),
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
                child: Text(
                  "Kitchen",
                  style: textFieldStyle18(),
                ),
              ),
              InkWell(
                onTap: () {},
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
                child: Text(
                  "My Desktop Clutter",
                  style: textFieldStyle18(),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
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
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtPrice,
              ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: (addBoxesController.isFragile.value) ? Colors.black : Colors.black,
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
                        value: addBoxesController.isFragile.value,
                        tristate: false,
                        onChanged: (bool isChecked) {
                          addBoxesController.isFragile.value = isChecked;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 10),
                  child: Text(
                    txtisFragile,
                    style: textFieldStyle20(),
                  ),
                ),
              ],
            ),
            TenSizeBox(),
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
          CustomButton(txtSave, 0, 0, () {}),
          if (flag == 0) TenSizeBox(),
          if (flag == 0) CustomButton(txtSaveAndAddAnotherItem, 0, 0, () {}),
        ],
      ),
    );
  }
}
