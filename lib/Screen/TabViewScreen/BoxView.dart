import 'package:flt_imo/Controller/BoxController/boxListingController.dart';
import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/noDataWidget.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/searchBar.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flt_imo/Screen/BoxItem/ItemWidget.dart';
import 'package:flt_imo/Screen/Collaboration/printQr.dart';
import 'package:flt_imo/Screen/Collaboration/share.dart';

class BoxView extends StatelessWidget {
  final BoxesListController boxController = Get.put(BoxesListController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: boxController.boxFuture,
          child: Scrollbar(
            thickness: 10,
            // isAlwaysShown: true,
            showTrackOnHover: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommanSearchBar(
                    onChanged: (text) {
                      text = text.toLowerCase();
                      boxController.boxListForDisplay = boxController.boxList.where((item) {
                        var itemName = item.description.toLowerCase();
                        return itemName.contains(text);
                      }).toList();
                      Get.forceAppUpdate();
                    },
                  ),
                  setListView(context, boxController.boxListForDisplay),
                ],
              ),
            ),
          ),
        ),
      ),
    ).wFull(context);
  }

  setListView(context, items) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Obx(() => boxController.isLoading.value
          ? progressIndicator()
          : boxController.boxListForDisplay.isEmpty
              ? noDataWidget(txtBoxes)
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var box = items[index];

                    return expandedBox(context, box);
                  },
                )),
    ).wFull(context);
  }

  expandedBox(context, Box box) {
    return Card(
        child: ExpansionTile(
      leading: Image.asset(Images.BOX),
      title: Center(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  bigTitle_textNormalGrey(title: '${box.description}', context: context),
                  SizedBox(
                    height: 5,
                  ),
                  title_text_black14(title: "Box Price ${box.price.toString()}", context: context),
                  SizedBox(
                    height: 5,
                  ),
                  title_text_grey16(title: 'Created on ${dateFormat.format(box.createdOn)}', context: context),
                  TenSizeBox(),
                ],
              ),
            ],
          ),
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(10)),
              child: "Total Item: ${box.boxItem.length}".text.white.lg.makeCentered().p4()),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ],
      ),
      childrenPadding: const EdgeInsets.symmetric(vertical: 15.0),
      tilePadding: EdgeInsets.all(20),
      children: List.generate(box.boxItem.length, (index) {
        // if (box.boxItem.length == index) {
        //   return Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 15.0),
        //     child: CustomButton("Close", 10, 10, () {}),
        //   );
        // }
        return ItemWidget(
          boxitem: box.boxItem[index],
        );
      }),
    ));
  }
}
