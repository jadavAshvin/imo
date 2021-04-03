import 'package:flt_imo/Controller/BoxesItemController/boxesItemController.dart';
import 'package:flt_imo/Models/Boxes/boxesDetail.dart';
import 'package:flt_imo/Models/Inventory/inventoryDetail.dart';
import 'package:flt_imo/Screens/Home/Projects/addBox/addBox.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/image_placeHolder.dart';
import 'package:flt_imo/Widget/noDataWidget.dart';
import 'package:flt_imo/Widget/pickers.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Screens/Home/Projects/addBoxItem/addBoxItem.dart';

class BoxesItemListScreen extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController());
  final Box box;

  BoxesItemListScreen(this.box);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: bigTitle_textNormal(title: box.description, context: context),
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
      child: GetX<BoxesItemController>(
        init: BoxesItemController(),
        initState: (_) {
          Get.find<BoxesItemController>().getItemList(box.key);
        },
        builder: (c) {
          return c.isLoading.value
              ? progressIndicator()
              : c.itemListForDisplay.isEmpty
                  ? noDataWidget(txtItem)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: c.itemListForDisplay.length,
                      itemBuilder: (context, index) {
                        var item = c.itemListForDisplay[index];
                        return setBoxesView(context, item);
                      },
                    );
        },
      ),
    );
  }

  setBoxesView(context, Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Get.to(AddBoxes(
                flag: 1,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 45),
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                              floatingCarouselPlaceHolder(item.images),
                              Container(
                                transform: Matrix4.translationValues(-20, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    bigTitle_textNormalGrey(title: '${item.title}', context: context),
                                    TenSizeBox(),
                                    title_text20NormalBlack(title: 'Quantity:${item.quantity}', context: context),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  title_text18Normal(title: '${dateFormat.format(item.createdOn)}', context: context),
                                  TenSizeBox(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      // Icon(
                                      //   Icons.share,
                                      //   color: greyDark,
                                      // ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: item.isSaleable ? Colors.green : Colors.red,
                                            ),
                                          ),
                                          TenSizeBoxWidth(),
                                          title_text_black14(title: "Saleable", context: context)
                                        ],
                                      ),
                                      TenSizeBox(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: item.isFragile ? Colors.green : Colors.red,
                                            ),
                                          ),
                                          TenSizeBoxWidth(),
                                          title_text_black14(title: "Fragile", context: context)
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              TenSizeBoxWidth()
                            ],
                          ),
                          // Container(
                          //   transform: Matrix4.translationValues(0, 10, 0),
                          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          //   decoration: BoxDecoration(
                          //     color: primaryColor,
                          //     borderRadius: BorderRadius.only(
                          //       bottomLeft: Radius.circular(10),
                          //       bottomRight: Radius.circular(10),
                          //     ),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       title_text_white14(title: 'Shared with 5 others', context: context),
                          //       title_text_white14(title: "Public", context: context),
                          //     ],
                          //   ),
                          // ),
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
                child: Icon(
                  CupertinoIcons.add,
                  size: 25,
                ),
                onTap: () {
                  Get.to(AddBoxItem());
                },
              ),
              TenSizeBoxWidth(),
              InkWell(
                child: Icon(
                  CupertinoIcons.search,
                  size: 25,
                ),
                onTap: () {},
              ),
              TenSizeBoxWidth(),
              InkWell(
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
