import 'package:flt_imo/Controller/TabViewController/dashboardController.dart';
import 'package:flt_imo/Screen/Boxes/boxListing.dart';
import 'package:flt_imo/Screen/ListingScreens/inventoryListScreen.dart';
import 'package:flt_imo/Screen/ListingScreens/locationListScreen.dart';
import 'package:flt_imo/Screen/ListingScreens/itemListing.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:velocity_x/velocity_x.dart';

class DashboardView extends StatelessWidget {
  final dashController = Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: dashController.bannerAd!);

    return Container(
      child: RefreshIndicator(
        onRefresh: dashController.getRefreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: Get.height,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: adWidget,
                  width: MediaQuery.of(context).size.width.toDouble(),
                  height: dashController.bannerAd!.size.height.toDouble(),
                ),
                SizedBox(
                  height: 50,
                ),
                GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20.0, mainAxisSpacing: 20),
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(() => LocationListScreen());
                        },
                        child: cardView(context, txtLocation, 0, Icons.location_city_outlined)),
                    InkWell(
                        onTap: () {
                          Get.to(() => InventoryList());
                        },
                        child: cardView(context, txtInventory, 1, Icons.storage)),
                    InkWell(
                        onTap: () {
                          Get.to(() => BoxesListScreen());
                        },
                        child: cardView(context, txtStorageBox, 2, Icons.inventory)),
                    InkWell(
                        onTap: () {
                          Get.to(() => BoxesItemListScreen());
                        },
                        child: cardView(context, txtItem, 3, Icons.all_inbox_rounded)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardView(BuildContext context, String title, int index, icon) {
    return buildTile(
      Padding(
        padding: const EdgeInsets.all(20.0),
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
                      .shimmer(gradient: LinearGradient(colors: [grey100!, greyLight!]), primaryColor: greyLight!)
                  : "${dashController.piedata[index].taskvalue}".text.bold.black.xl5.makeCentered()),
              // Text('${dashController.piedata[index].taskvalue}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
            ],
          ),
          Center(child: Icon(icon, color: primaryColor, size: 40.0))
        ]),
      ),
    );
  }
}

Widget buildTile(Widget child) {
  return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      // shadowColor: Color(0x802196F3),
      child: child);
}
