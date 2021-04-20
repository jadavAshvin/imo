import 'package:flt_imo/Controller/AddScreensController/addInventoryController.dart';
import 'package:flt_imo/NoInternetConnection/no_internet.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/decorationConstant.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/GetThings/locationDailog.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInventory extends StatelessWidget {
  final flag;

  AddInventory({Key key, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        child: CustomNewAppBar(null, flag == 1 ? txtEditInventory : txtCreateInventory, "", "", () {}),
        preferredSize: Size.fromHeight(100),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GetX<CreateInventoryController>(
          init: CreateInventoryController(),
          initState: (_) {},
          builder: (c) {
            return c.isDetailLoading.value
                ? progressIndicator()
                : ListView(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      setTextFieldView(context, c),
                      FifteenSizeBox(),
                      Obx(() => c.processLoading.value
                          ? CustomButtonProgress(0, 0)
                          : CustomButton(flag == 1 ? txtupdate : txtCreate, 0, 0, () {
                              print("Add Btn ${c.locid}");
                              c.addBtn(flag);
                            })),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget setTextFieldView(BuildContext context, c) {
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
                      "${c.selectedLocation.value.name}",
                      style: textFieldStyle18(),
                    )),
              ),
              InkWell(
                onTap: () async {
                  if (await isConnected()) {
                    var loc = await locationBottom(AppConstants.PROJECT.id.toString());
                    if (loc != null) {
                      c.selectedLocation.value = loc;
                      c.update();
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
              controller: c.inventoryNameController,
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
