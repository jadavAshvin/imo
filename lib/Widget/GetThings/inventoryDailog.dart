import 'package:flt_imo/Models/Location/locationList.dart';
import 'package:flt_imo/Utils/Apis/locationApis.dart';

import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryDailogController extends GetxController {
  List<Inventory> inventoryList = List<Inventory>.empty(growable: true).obs;
  var isLocLoading = true.obs;
  var hasValue = false.obs;
  getinventoryList(id) async {
    isLocLoading(true);
    await locationDetailApi(id).then((response) {
      if (response.statusCode == 200) {
        var i = locationListFromJson(response.body);
        inventoryList = i.inventories;
      } else {
        inventoryList = [];
      }
    });
    isLocLoading(false);
  }
}

inventoryDailog(id) {
  return Get.defaultDialog(
    title: txtSelectProject,
    content: Container(
      width: Get.width / 1.25,
      height: Get.height / 5,
      child: GetX<InventoryDailogController>(
        init: Get.put(InventoryDailogController()),
        initState: (_) {
          Get.find<InventoryDailogController>().getinventoryList(id);
        },
        builder: (c) {
          return c.isLocLoading.value
              ? progressIndicator()
              : c.inventoryList.isEmpty
                  ? Center(child: Text("No inventory available"))
                  : ListView.separated(
                      itemCount: c.inventoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.back(result: c.inventoryList[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: title_text20NormalBlack(title: c.inventoryList[index].name, context: context),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
        },
      ),
    ),
  );
}

Future<Inventory> inventoryBottom(id) async {
  return Get.bottomSheet(
    Container(
      width: Get.width / 1.25,
      height: Get.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 10, right: 10),
            child: GetX<InventoryDailogController>(
              init: Get.put(InventoryDailogController()),
              initState: (_) {
                Get.find<InventoryDailogController>().getinventoryList(id);
              },
              builder: (c) {
                return c.isLocLoading.value
                    ? progressIndicator()
                    : c.inventoryList.isEmpty
                        ? Center(child: Text("No inventory available"))
                        : ListView.separated(
                            itemCount: c.inventoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.back(result: c.inventoryList[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: title_text20NormalBlack(title: c.inventoryList[index].name, context: context),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider();
                            },
                          );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff7687a2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
