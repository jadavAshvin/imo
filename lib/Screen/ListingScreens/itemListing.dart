import 'package:flt_imo/Controller/BoxItemController/itemListingController.dart';
import 'package:flt_imo/Models/boxItemModel.dart';
import 'package:flt_imo/Screen/AddScreens/addBoxItem.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
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
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BoxesItemListScreen extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController());

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
          child: bigTitle_textNormal(title: AppConstants.PROJECT.name, context: context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              setSearchView(context),
              setListView(context),
            ],
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
          Get.find<BoxesItemController>().getItemList();
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

  setBoxesView(context, BoxItem item) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
      ),
      child: InkWell(
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10,
            color: white,
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
              ),
              child: Column(
                children: <Widget>[
                  TenSizeBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${dateFormat.format(item.createdOn)}",
                        style: TextStyle(
                          color: headerTextColor,
                        ),
                      ),
                      PopupMenuButton<PageEnum>(
                          onSelected: (PageEnum value) {
                            switch (value) {
                              case PageEnum.edit:
                                Get.back();

                                break;
                              case PageEnum.delete:
                                Get.back();
                                deleteDialog();
                                break;
                            }
                          },
                          child: Icon(Icons.more_vert),
                          itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                                PopupMenuItem<PageEnum>(
                                  value: PageEnum.edit,
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem<PageEnum>(
                                  value: PageEnum.delete,
                                  child: Text('Delete'),
                                ),
                              ])
                    ],
                  ),
                  Container(
                    child: "${item.title}".text.semiBold.xl4.makeCentered(),
                  ).wFull(context),
                  TenSizeBox(),
                  Container(
                    child: "${item.description}".text.sm.gray600.makeCentered(),
                  ).wFull(context),
                  TenSizeBox(),
                  Container(
                    height: 170,
                    width: Get.width,
                    child: item.images.isEmpty
                        ? "No Image available".text.xl3.makeCentered()
                        : CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                            ),
                            items: List.generate(item.images.length, (index) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      // width: MediaQuery.of(context).size.width,
                                      // decoration: BoxDecoration(color: Colors.amber),
                                      child: FadeInImage.assetNetwork(
                                    placeholder: Images.PLACE_HOLDER,
                                    image: item.images[index],
                                    // .replaceAll('\\', '//'),
                                    fit: BoxFit.fitHeight,
                                    // width: 110.0,
                                    // height: 110.0,
                                  ));
                                },
                              );
                            }),
                          ),
                  ),
                  FifteenSizeBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            "Price: ${item.price}".text.semiBold.white.xl.make(),
                            "Quantity: ${item.quantity}".text.semiBold.white.xl.make(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FifteenSizeBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
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
                          "Saleable".text.bold.xl.make()
                        ],
                      ),
                      Row(
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
                          "Fragile".text.bold.xl.make()
                        ],
                      ),
                      Row(
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
                          "Negotiable".text.bold.xl.make(),
                        ],
                      ),
                    ],
                  ),
                  TenSizeBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // setBoxesView(context, BoxItem item) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Stack(
  //       children: [
  //         InkWell(
  //           onTap: () {},
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
  //             child: Container(
  //               transform: Matrix4.translationValues(0, 0, 0),
  //               child: Card(
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                 elevation: 5,
  //                 color: white,
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: <Widget>[
  //                             Container(
  //                               transform: Matrix4.translationValues(0, 0, 0),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: <Widget>[
  //                                   bigTitle_textNormalGrey(title: '${item.title}', context: context),
  //                                   TenSizeBox(),
  //                                   title_text20NormalBlack(title: 'Quantity:${item.quantity}', context: context),
  //                                 ],
  //                               ),
  //                             ),
  //                             Spacer(),
  //                             Column(
  //                               crossAxisAlignment: CrossAxisAlignment.end,
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               children: <Widget>[
  //                                 title_text18Normal(title: '${dateFormat.format(item.createdOn)}', context: context),
  //                                 TenSizeBox(),
  //                                 Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   children: <Widget>[
  //                                     // Icon(
  //                                     //   Icons.share,
  //                                     //   color: greyDark,
  //                                     // ),
  //                                     Row(
  //                                       children: [
  //                                         Container(
  //                                           width: 10,
  //                                           height: 10,
  //                                           decoration: BoxDecoration(
  //                                             borderRadius: BorderRadius.circular(20),
  //                                             color: item.isSaleable ? Colors.green : Colors.red,
  //                                           ),
  //                                         ),
  //                                         TenSizeBoxWidth(),
  //                                         title_text_black14(title: "Saleable", context: context)
  //                                       ],
  //                                     ),
  //                                     TenSizeBox(),
  //                                     Row(
  //                                       mainAxisAlignment: MainAxisAlignment.end,
  //                                       children: [
  //                                         Container(
  //                                           width: 10,
  //                                           height: 10,
  //                                           decoration: BoxDecoration(
  //                                             borderRadius: BorderRadius.circular(20),
  //                                             color: item.isFragile ? Colors.green : Colors.red,
  //                                           ),
  //                                         ),
  //                                         TenSizeBoxWidth(),
  //                                         title_text_black14(title: "Fragile", context: context)
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             ),
  //                             TenSizeBoxWidth()
  //                           ],
  //                         ),
  //                         // Container(
  //                         //   transform: Matrix4.translationValues(0, 10, 0),
  //                         //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
  //                         //   decoration: BoxDecoration(
  //                         //     color: primaryColor,
  //                         //     borderRadius: BorderRadius.only(
  //                         //       bottomLeft: Radius.circular(10),
  //                         //       bottomRight: Radius.circular(10),
  //                         //     ),
  //                         //   ),
  //                         //   child: Row(
  //                         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         //     children: <Widget>[
  //                         //       title_text_white14(title: 'Shared with 5 others', context: context),
  //                         //       title_text_white14(title: "Public", context: context),
  //                         //     ],
  //                         //   ),
  //                         // ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         // Container(
  //         //   child: ImageView(Images.IMAGE_GALLERY, 100, 100),
  //         // ),
  //       ],
  //     ),
  //   );
  // }

  setSearchView(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 18.0, left: 18.0),
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
