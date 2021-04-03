import 'package:flt_imo/Controller/InventoryController/inventoryListController.dart';
import 'package:flt_imo/Models/Location/locationList.dart';
import 'package:flt_imo/Models/Project/projectDetailResponse.dart';
import 'package:flt_imo/Screens/Home/Projects/AddLocation/addLocation.dart';
import 'package:flt_imo/Screens/Home/Projects/BoxList/boxListScreen.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateInventory/CreateInventory.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/dialog.dart';
import 'package:flt_imo/Widget/pickers.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryList extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController())00;
  final Location loc;

  InventoryList(this.loc);
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
          child: bigTitle_textNormal(title: loc.name, context: context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: black,
            ),
            onPressed: () {
              Get.to(AddLocation(
                1,
                "inventorylist",
              ));
            },
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
      child: GetX<InventoryListController>(
        init: Get.put(InventoryListController()),
        initState: (_) {
          Get.find<InventoryListController>().getInventoryList(loc.id.toString());
        },
        builder: (c) {
          return c.isLoading.value
              ? progressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: c.inventoryListForDisplay.length,
                  itemBuilder: (context, index) {
                    var inventory = c.inventoryListForDisplay[index];
                    return setBoxesView(context, inventory, c);
                  },
                );
        },
      ),
    );
  }

  setBoxesView(context, Inventory inventory, InventoryListController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
            child: InkWell(
              onTap: () {
                Get.to(BoxesListScreen(inventory));
              },
              onLongPress: () {
                editDeleteDailog(() {
                  Get.back();
                  Get.to(CreateInventory(
                    flag: 1,
                    screen: "inventorylist",
                    inv: inventory.name,
                    invid: inventory.id,
                  ));
                }, () {
                  Get.back();
                  deleteDialog(
                      entity: "inventory",
                      function: () {
                        c.deleteInventory(inventory.id.toString(), loc.id.toString());
                      });
                });
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
                                    bigTitle_textNormalGrey(title: '${inventory.name}', context: context),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TenSizeBox(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        title_text16Bold(title: '${inventory.boxesCount} Boxes', context: context),
                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        // Spacer(),
                                        title_text_grey16(title: 'Created on ${dateFormat.format(inventory.createdOn)}', context: context),
                                      ],
                                    ),
                                    TenSizeBox(),
                                  ],
                                ),
                              ),
                              Spacer()
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
          title_text20BoldBlack(context: context, title: txtinventories),
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
                  Get.to(CreateInventory(
                    flag: 0,
                    screen: "inventorylist",
                  ));
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
