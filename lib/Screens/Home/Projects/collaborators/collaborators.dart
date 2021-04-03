import 'package:flt_imo/Controller/ProjectControllers/Collaborators/sharescreenController.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/decoration.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Collaborators extends StatelessWidget {
  final ShareScreenController shareController = Get.put(ShareScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Center(
            child: bigTitle_textNormal(title: txtCollaborators, context: context),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FifteenSizeBox(),
                    setCustomEmail(),
                    SizedBox(
                      height: 200,
                    )
                    // Spacer(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: 100,
                color: white,
                child: setButtons(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 50),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(txtSave, 0, 0, () {}),
            TenSizeBox(),
            CustomButton(txtSaveAndAddAnotherBox, 0, 0, () {}),
          ],
        ),
      ),
    );
  }

  dailog() {
    List access = ['Full', 'Read Only', 'Revoke'];
    return Get.defaultDialog(
      title: 'Select Access Level',
      content: Container(
        width: Get.width / 1.25,
        height: Get.height / 6.5,
        child: ListView.separated(
          itemCount: access.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: title_text20NormalBlack(title: access[index], context: context),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  setCustomEmail() {
    return Obx(() => shareController.emailIndex.value == 0
        ? InkWell(
            onTap: () {
              shareController.emailIndex += 1;
              shareController.update();
            },
            child: Container(
              height: Get.height / 20,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: boxDecorationWhite(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    txtAddAnotherMail,
                    style: textFieldStyle18White(),
                  ),
                ),
              ),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: shareController.emailIndex.value + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == shareController.emailIndex.value) {
                return Padding(
                  padding: const EdgeInsets.only(left: 100, top: 15),
                  child: InkWell(
                    onTap: () {
                      shareController.emailIndex += 1;
                      shareController.update();
                    },
                    child: Container(
                      height: 40.0,
                      decoration: boxDecorationWhite(),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            txtAddAnotherMail,
                            style: textFieldStyle18White(),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return setItemView(context, txtEmail);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 2,
              );
            },
          ));
  }

  setItemView(context, hintText) {
    return Container(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 20, right: 20),
        //decoration: boxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              txtAccess,
              style: textFieldStyle20BoldUnderLine(),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Read Only",
                    style: textFieldStyle18(),
                  ),
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
            Container(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
              //decoration: boxDecoration(),
              child: TextFormField(
                style: textFieldStyle20(),
                //  onEditingComplete: () => loginController.focus.unfocus(),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: hintText,
                ),
                textInputAction: TextInputAction.next,
              ),
            ),
            TenSizeBox()
          ],
        ));
  }
}
