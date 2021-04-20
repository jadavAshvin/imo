import 'package:flt_imo/Controller/TabViewController/dashboardController.dart';
import 'package:flt_imo/Screen/ListingScreens/inventoryListScreen.dart';
import 'package:flt_imo/Screen/ListingScreens/locationListScreen.dart';
import 'package:flt_imo/Screen/ListingScreens/itemListing.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardView extends StatelessWidget {
  final dashController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      child: RefreshIndicator(
        onRefresh: dashController.getRefreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(LocationListScreen());
                  },
                  child: cardView(context, txtLocation, 0, Icons.location_city_outlined)),
              FifteenSizeBox(),
              GestureDetector(
                  onTap: () {
                    Get.to(InventoryList());
                  },
                  child: cardView(context, txtInventory, 1, Icons.storage)),
              FifteenSizeBox(),
              cardView(context, txtStorageBox, 2, Icons.inventory),
              FifteenSizeBox(),
              GestureDetector(
                  onTap: () {
                    Get.to(BoxesItemListScreen());
                  },
                  child: cardView(context, txtItem, 3, Icons.all_inbox_rounded)),
              SizedBox(
                height: Get.height,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardView(BuildContext context, String title, int index, icon) {
    return buildTile(
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('$title', style: TextStyle(color: primaryColor, fontSize: 20)),
              FifteenSizeBoxWidth(),
              Obx(() => dashController.isLoading.value
                  ? Container()
                      .circle(radius: 40, backgroundColor: grey)
                      .shimmer(gradient: LinearGradient(colors: [grey100, greyLight]), primaryColor: greyLight)
                  : "${dashController.piedata[index].taskvalue}".text.bold.black.xl5.makeCentered()),
              // Text('${dashController.piedata[index].taskvalue}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
            ],
          ),
          Material(
              color: primaryColor,
              borderRadius: BorderRadius.circular(24.0),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(icon, color: Colors.white, size: 30.0),
              )))
        ]),
      ),
    );
  }
}

Widget buildTile(Widget child, {Function() onTap}) {
  return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: GestureDetector(
          // Do onTap() if it isn't null, otherwise do print()
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print('Not set yet');
                },
          child: child));
}
