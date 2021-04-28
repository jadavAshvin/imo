import 'package:flt_imo/Controller/AddScreensController/addLocationController.dart';
import 'package:flt_imo/Screen/MapSearch/searchAddress.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLocation extends StatelessWidget {
  final flag;
  final AddLocationController addLocationController = Get.put(AddLocationController());
  AddLocation({Key key, this.flag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                labelText: txtEnterLocationName,
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
                      labelText: txtLocationAddress,
                    ),
                    textInputAction: TextInputAction.newline,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await Get.to(SearchAddress());
                  addLocationController.enterAddressController.text = AppConstants.ADDRESS;
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
        ],
      ),
    );
  }
}
