import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxItemWidget extends StatelessWidget {
  final Box box;

  const BoxItemWidget({@required this.box});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
              child: InkWell(
                onTap: () {
                  // Get.to(BoxesItemListScreen(box));
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
                                          title_text16Bold(title: '${box.boxItem.length} Items', context: context),
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
                                                    // Get.to(ShareScreen());
                                                  },
                                                  child: Icon(
                                                    Icons.share,
                                                    color: greyDark,
                                                  ),
                                                ),
                                                FifteenSizeBoxWidth(),
                                                InkWell(
                                                  onTap: () {
                                                    // Get.to(PrintQR());
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
                                // Get.to(Collaborators());
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
      ),
    );
  }
}
