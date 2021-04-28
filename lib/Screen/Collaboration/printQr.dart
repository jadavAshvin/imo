import 'package:flt_imo/Utils/decorationConstant.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Controller/Collaborator/PrinterController.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PrintQR extends StatelessWidget {
  final PrinterController printerController = Get.put(PrinterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        child: CustomNewAppBar(null, txtPrint, "", "", () {}),
        preferredSize: Size.fromHeight(100),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            qrPhoto(),
            FifteenSizeBox(),
            Center(
              child: title_text20NormalBlack(title: "DGHIW786521WG", context: context),
            ),
            SizedBox(
              height: Get.height / 13,
            ),
            setTextFieldView(context),
            FifteenSizeBox(),
            selectPrinter(),
            FifteenSizeBox(),
            FifteenSizeBox(),
            CustomButton(txtPrint, 0, 0, () {}),
          ],
        ),
      ),
    );
  }

  Widget qrPhoto() {
    return Container(
      child: Image.asset(
        Images.QRCODE,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget selectPrinter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          txtPrinter,
          style: textFieldStyle20BoldUnderLine(),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Obx(() => Text(
                    printerController.selectedPrinter.value,
                    style: textFieldStyle18(),
                  )),
            ),
            InkWell(
              onTap: () {
                dailog();
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
    );
  }

  dailog() {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: Get.width / 1.25,
        height: Get.height / 3,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: ListView.separated(
                itemCount: printerController.printer.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Get.back();
                      printerController.selectedPrinter.value = printerController.printer[index];
                      printerController.update();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: title_text20NormalBlack(title: printerController.printer[index], context: context),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff7687a2),
                    ),
                  ),
                ],
              ),
            ),
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
              keyboardType: TextInputType.number,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                labelText: txtEnterNumberCopies,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}
