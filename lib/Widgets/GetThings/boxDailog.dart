import 'dart:convert';

import 'package:flt_imo/Models/BoxModel.dart';
import 'package:flt_imo/Service/boxService.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxDailogController extends GetxController {
  List<Box>? boxList = List<Box>.empty(growable: true).obs;
  var isLocLoading = true.obs;
  var hasValue = false.obs;
  getinventoryList(id) async {
    isLocLoading(true);
    await BoxService.boxesListApi().then((response) {
      if (response != null) {
        var b = boxFromJson(jsonEncode(response.body));
        boxList = b;
        // boxListForDisplay = boxList;
      } else {
        boxList = [];
        // boxListForDisplay = boxList;
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
      child: GetX<BoxDailogController>(
        init: Get.put(BoxDailogController()),
        initState: (_) {
          Get.find<BoxDailogController>().getinventoryList(id);
        },
        builder: (c) {
          return c.isLocLoading.value
              ? progressIndicator()
              : c.boxList!.isEmpty
                  ? Center(child: Text("No inventory available"))
                  : ListView.separated(
                      itemCount: c.boxList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.back(result: c.boxList![index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: title_text20NormalBlack(title: c.boxList![index].title!, context: context),
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

Future<Box?> boxBottom(id) async {
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
            child: GetX<BoxDailogController>(
              init: Get.put(BoxDailogController()),
              initState: (_) {
                Get.find<BoxDailogController>().getinventoryList(id);
              },
              builder: (c) {
                return c.isLocLoading.value
                    ? progressIndicator()
                    : c.boxList!.isEmpty
                        ? Center(child: Text("No box available"))
                        : ListView.separated(
                            itemCount: c.boxList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.back(result: c.boxList![index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: title_text20NormalBlack(title: c.boxList![index].title!, context: context),
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
