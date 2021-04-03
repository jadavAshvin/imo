import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Controller/LocationController/locationController.dart';
import 'package:flt_imo/Models/Project/projectDetailResponse.dart';
import 'package:flt_imo/Models/Project/projectListResponse.dart';
import 'package:flt_imo/Screens/Home/Projects/AddLocation/addLocation.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateNewProject/createProject.dart';
import 'package:flt_imo/Screens/Home/Projects/InventoryList/inventoryList.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/noDataWidget.dart';
import 'package:flt_imo/Widget/pickers.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';

import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationListScreen extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController());
  final ProjectList project;

  LocationListScreen(this.project);
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
          child: bigTitle_textNormal(title: "${project.name}", context: context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: black,
            ),
            onPressed: () {
              Get.to(CreateProjects(
                1,
                "locationlist",
                project: project,
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
      child: GetX<LocationController>(
        init: Get.put(LocationController()),
        initState: (_) {
          Get.find<LocationController>().getLocationList(project.id.toString());
        },
        builder: (c) {
          return c.isLoading.value
              ? progressIndicator()
              : c.locationListForDisplay.isEmpty
                  ? noDataWidget(txtLocation)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: c.locationListForDisplay.length,
                      itemBuilder: (context, index) {
                        var loc = c.locationListForDisplay[index];
                        return setBoxesView(context, loc);
                      },
                    );
        },
      ),
    );
  }

  setBoxesView(context, Location loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 0),
            child: InkWell(
              onTap: () {
                AppConstants.LOCATION_OBJECT = loc;
                Get.to(InventoryList(loc));
              },
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8, right: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(5),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: 1,
                                  //     blurRadius: 5,
                                  //     offset: Offset(2, 4), // changes position of shadow
                                  //   ),
                                  // ],
                                ),
                                transform: Matrix4.translationValues(0, -7, 0),
                                child: Image.asset(
                                  Images.MAP,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              TenSizeBoxWidth(),
                              Container(
                                width: Get.width / 1.28,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        bigTitle_textNormalGrey(title: '${loc.name}', context: context),
                                        title_text_grey17head(title: 'Created On ${dateFormat.format(loc.createdOn)}', context: context)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: Get.width / 2,
                                      child: title_text_black16(title: '${loc.address}', context: context),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                        decoration: BoxDecoration(color: Colors.green[400], borderRadius: BorderRadius.circular(5)),
                                        child: title_text_white16bold(title: '40 Boxes in ${loc.inventoriesCount} Inventories', context: context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          )
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
          title_text20BoldBlack(context: context, title: txtLocation),
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
                  Get.to(AddLocation(0, "LocationList"));
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
