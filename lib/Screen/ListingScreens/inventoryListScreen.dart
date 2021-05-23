import 'package:flt_imo/Controller/InventoryController/inventoryListController.dart';
import 'package:flt_imo/Models/inventoryModel.dart';
import 'package:flt_imo/Screen/AddScreens/addInventory.dart';
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
import 'package:velocity_x/velocity_x.dart';

class InventoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inController = Get.put(InventoryListController());
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
          child: bigTitle_textNormal(title: AppConstants.PROJECT.name, context: context),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 0),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: inController.getInvRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: setListView(context, inController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: setSearchView(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setListView(context, InventoryListController inController) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Obx(
        () {
          print("In file: ${inController.inventoryList}");
          return inController.isLoading.value
              ? progressIndicator()
              : inController.inventoryList.isEmpty
                  ? Container(height: Get.height, child: noDataWidget(txtInventory))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: inController.inventoryList.length,
                      itemBuilder: (context, index) {
                        var inventory = inController.inventoryList[index];

                        return setBoxesView(context, inventory, inController);
                      },
                    );
        },
      ),
    ).wFull(context);
  }

  setBoxesView(context, Inventory inventory, InventoryListController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
            child: InkWell(
              onTap: () {},
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
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0, right: 5),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: PopupMenuButton<PageEnum>(
                                      onSelected: (PageEnum value) {
                                        switch (value) {
                                          case PageEnum.edit:
                                            Get.to(AddInventory(flag: 1, inventory: inventory));
                                            break;
                                          case PageEnum.delete:
                                            deleteDialog(
                                                entity: txtInventory,
                                                function: () {
                                                  Get.back();
                                                  c.deleteInventory(context, inventory.id);
                                                });
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
                                          ]),
                                ),
                              )
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

  Widget setSearchView(context) {
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
                  Get.to(AddInventory(flag: 0));
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
