import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/Models/projectDetail.dart';
import 'package:flt_imo/Service/projectService.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationDailogController extends GetxController {
  List<Location> locationList = List<Location>.empty(growable: true).obs;
  var isLocLoading = true.obs;
  var hasValue = false.obs;
  getLocationList(id) async {
    isLocLoading(true);
    await projectDetailApi(id).then((response) {
      if (response.statusCode == 200) {
        var l = projectDetailFromJson(response.body);
        locationList = l.locations;
      } else {
        locationList = [];
      }
    });
    isLocLoading(false);
  }
}

locationDailog(id) {
  return Get.defaultDialog(
    title: txtSelectProject,
    content: Container(
      width: Get.width / 1.25,
      height: Get.height / 5,
      child: GetX<LocationDailogController>(
        init: Get.put(LocationDailogController()),
        initState: (_) {
          Get.find<LocationDailogController>().getLocationList(id);
        },
        builder: (c) {
          return c.isLocLoading.value
              ? progressIndicator()
              : c.locationList.isEmpty
                  ? Center(child: Text("No location available"))
                  : ListView.separated(
                      itemCount: c.locationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Get.back(result: c.locationList[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: title_text20NormalBlack(title: c.locationList[index].name, context: context),
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

locationBottom(id) async {
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
            child: GetX<LocationDailogController>(
              init: Get.put(LocationDailogController()),
              initState: (_) {
                Get.find<LocationDailogController>().getLocationList(id);
              },
              builder: (c) {
                return c.isLocLoading.value
                    ? progressIndicator()
                    : c.locationList.isEmpty
                        ? Center(child: Text("No location available"))
                        : ListView.separated(
                            itemCount: c.locationList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.back(result: c.locationList[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: title_text20NormalBlack(title: c.locationList[index].name, context: context),
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
