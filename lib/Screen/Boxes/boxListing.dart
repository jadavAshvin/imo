import 'package:flt_imo/Controller/BoxController/boxListingController.dart';
import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Screen/AddScreens/addBox.dart';
import 'package:flt_imo/Screen/Collaboration/printQr.dart';
import 'package:flt_imo/Screen/ListingScreens/itemListing.dart';
import 'package:flt_imo/Utils/app_constants.dart';

import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';

import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/noDataWidget.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxesListScreen extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController())00;

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
        centerTitle: true,
        title: bigTitle_textNormal(title: AppConstants.PROJECT.name!, context: context),
        actions: [],
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
          Get.find<BoxesListController>().getboxesList();
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
                        return setBoxesView(context, box, c);
                      },
                    );
        },
      ),
    );
  }
  // Get.to(BoxesItemListScreen(boxId: box.key, boxName: box.title));

  setBoxesView(context, Box box, BoxesListController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
            child: InkWell(
              onTap: () {
                Get.to(BoxesItemListScreen(boxId: box.key, boxName: box.title));
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
                                        title_text16Bold(title: '${box.boxItem!.length} Items', context: context),
                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        // Spacer(),
                                        title_text_grey16(title: 'Created on ${dateFormat.format(box.createdOn!)}', context: context),

                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                borderRadius: BorderRadius.circular(10),
                                                onTap: () {
                                                  // Get.to(ShareScreen());
                                                },
                                                child: Icon(
                                                  Icons.share,
                                                  color: greyDark,
                                                ),
                                              ),
                                              FifteenSizeBoxWidth(),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {},
                                child: Icon(
                                  Icons.edit,
                                  color: greyDark,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  deleteDialog(
                                      entity: txtBox,
                                      function: () {
                                        Get.back();
                                      });
                                },
                                child: Icon(
                                  CupertinoIcons.delete,
                                  color: greyDark,
                                ),
                              ),
                            ],
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
                  Get.to(AddBox(flag: 0));
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
