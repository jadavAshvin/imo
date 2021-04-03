// BoxesListScreen
import 'package:flt_imo/Controller/BoxeListController/boxesListController.dart';
import 'package:flt_imo/Models/Inventory/inventoryDetail.dart';
import 'package:flt_imo/Models/Location/locationList.dart';
import 'package:flt_imo/Screens/Home/Projects/BoxesItemList/boxesItemListScreen.dart';
import 'package:flt_imo/Screens/Home/Projects/PrintQr/printQr.dart';
import 'package:flt_imo/Screens/Home/Projects/addBox/addBox.dart';
import 'package:flt_imo/Screens/Home/Projects/collaborators/collaborators.dart';
import 'package:flt_imo/Screens/Home/Projects/collaborators/sharescreen.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/noDataWidget.dart';
import 'package:flt_imo/Widget/pickers.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxesListScreen extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController())00;
  final Inventory inv;

  BoxesListScreen(this.inv);
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
        title: Center(
          child: bigTitle_textNormal(title: inv.name, context: context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                setSearchView(context),
                setListView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setListView(context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: GetX<BoxesListController>(
        init: Get.put(BoxesListController()),
        initState: (_) {
          Get.find<BoxesListController>().getboxesList(inv.id.toString());
        },
        builder: (c) {
          return c.isLoading.value
              ? progressIndicator()
              : c.boxListForDisplay.isEmpty
                  ? noDataWidget(txtBoxes)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: c.boxListForDisplay.length,
                      itemBuilder: (context, index) {
                        var box = c.boxListForDisplay[index];
                        return setBoxesView(context, box);
                      },
                    );
        },
      ),
    );
  }

  setBoxesView(context, Box box) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
            child: InkWell(
              onTap: () {
                Get.to(BoxesItemListScreen(box));
              },
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                transform: Matrix4.translationValues(20, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: Get.width / 1.15,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          bigTitle_textNormalGrey(title: '${box.description}', context: context),
                                          title_text_black14(title: "Box Price ${box.price.toString()}", context: context)
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TenSizeBox(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: <Widget>[
                                        title_text16Bold(title: '${box.iteminventorys.length} Items', context: context),
                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        // Spacer(),
                                        title_text_grey16(title: 'Created on ${dateFormat.format(box.createdOn)}', context: context),

                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            children: [
                                              InkWell(
                                                borderRadius: BorderRadius.circular(10),
                                                onTap: () {
                                                  Get.to(ShareScreen());
                                                },
                                                child: Icon(
                                                  Icons.share,
                                                  color: greyDark,
                                                ),
                                              ),
                                              FifteenSizeBoxWidth(),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(PrintQR());
                                                },
                                                child: Icon(
                                                  CupertinoIcons.printer,
                                                  color: greyDark,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TenSizeBox(),
                                  ],
                                ),
                              ),
                              Spacer()
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(Collaborators());
                            },
                            child: Container(
                              transform: Matrix4.translationValues(0, 15, 0),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  title_text_white14(title: 'Shared with 5 others', context: context),
                                  title_text_white14(title: "Public", context: context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   child: ImageView(Images.IMAGE_GALLERY, 100, 100),
          // ),
        ],
      ),
    );
  }

  setSearchView(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 0, right: 8.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title_text20BoldBlack(context: context, title: txtBoxes),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(15),
                child: Icon(
                  CupertinoIcons.add,
                  size: 25,
                ),
                onTap: () {
                  Get.to(AddBoxes(
                    flag: 0,
                    screen: "boxlist",
                  ));
                },
              ),
              TenSizeBoxWidth(),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                child: Icon(
                  CupertinoIcons.search,
                  size: 25,
                ),
                onTap: () {},
              ),
              TenSizeBoxWidth(),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                child: Icon(
                  Icons.sort,
                  size: 25,
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
