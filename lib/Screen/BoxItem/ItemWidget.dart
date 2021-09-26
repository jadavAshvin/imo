import 'package:flt_imo/Models/boxItemModel.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemWidget extends StatelessWidget {
  final BoxItem boxitem;
  final imageList = ["https://picsum.photos/410", "https://www.fillmurray.com/640/360", "https://picsum.photos/500", "https://picsum.photos/600"];
  ItemWidget({Key? key, required this.boxitem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                        "${dateFormat.format(boxitem.createdOn!)}",
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
                    child: "${boxitem.title}".text.semiBold.xl4.makeCentered(),
                  ).wFull(context),
                  TenSizeBox(),
                  Container(
                    child: "${boxitem.description}".text.sm.gray600.makeCentered(),
                  ).wFull(context),
                  TenSizeBox(),
                  Container(
                      height: 170,
                      width: Get.width,
                      child: boxitem.images!.isEmpty
                          ? "No Image available".text.xl3.makeCentered()
                          : VxSwiper.builder(
                              itemCount: imageList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    // decoration: BoxDecoration(color: Colors.amber),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: Images.PLACE_HOLDER,
                                      image: imageList[index],
                                      fit: BoxFit.fitWidth,
                                    ));
                              },
                            )

                      // CarouselSlider(
                      //     options: CarouselOptions(
                      //       enlargeCenterPage: true,
                      //       autoPlay: true,
                      //     ),
                      //     items: List.generate(imageList.length, (index) {
                      //       return Builder(
                      //         builder: (BuildContext context) {
                      //           return Container(
                      //               width: MediaQuery.of(context).size.width,
                      //               // decoration: BoxDecoration(color: Colors.amber),
                      //               child: FadeInImage.assetNetwork(
                      //                 placeholder: Images.PLACE_HOLDER,
                      //                 image: imageList[index],
                      //                 fit: BoxFit.fitWidth,
                      //               ));
                      //         },
                      //       );
                      //     }),
                      //   ),
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
                            "Price: ${boxitem.price}".text.semiBold.white.xl.make(),
                            "Quantity: ${boxitem.quantity}".text.semiBold.white.xl.make(),
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
                              color: boxitem.isFragile! ? Colors.green : Colors.red,
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
                              color: boxitem.isFragile! ? Colors.green : Colors.red,
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
                              color: boxitem.isFragile! ? Colors.green : Colors.red,
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
}
