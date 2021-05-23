import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/decorationConstant.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Controller/Collaborator/shareController.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flt_imo/Widgets/textStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareScreen extends StatelessWidget {
  final ShareController shareController = Get.put(ShareController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
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
              child: bigTitle_textNormal(title: txtShare, context: context),
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: grey,
            labelColor: black,
            indicatorColor: grey,
            labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
            tabs: [
              Tab(
                text: txtPhoneContact,
              ),
              Tab(
                text: txtCustomEmail,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Container(
                child: Stack(
                  children: [
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
              Container(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          setCustomEmail(),
                          SizedBox(
                            height: 200,
                          ),
                        ],
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
            ],
          ),
        ),
      ),
    );
  }

  setPhoneContacts() {}
  setCustomEmail() {
    return Obx(() => shareController.emailIndex.value == 0
        ? InkWell(
            onTap: () {
              shareController.emailIndex += 1;
              shareController.update();
            },
            child: Container(
              height: 40.0,
              decoration: boxDecorationWhite(),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
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
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
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

  dailog() {
    List access = ['Full', 'Read Only'];
    return Get.defaultDialog(
      title: 'Select Access Level',
      content: Container(
        width: Get.width / 1.25,
        height: Get.height / 6,
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

  Widget setButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 50),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(txtSend, 0, 0, () {}),
          ],
        ),
      ),
    );
  }

  setItemView(context, hintText) {
    return Container(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 15, right: 15),
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
