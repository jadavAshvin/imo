import 'package:flt_imo/Controller/LocationController/locationListController.dart';
import 'package:flt_imo/Models/locationModel.dart';
import 'package:flt_imo/Screen/AddScreens/addLocation.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/noDataWidget.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Widgets/CustomSearchBar.dart';

class LocationListScreen extends StatefulWidget {
  // final HomeController homeController = Get.put(HomeController());

  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
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
          child: bigTitle_textNormal(title: "${AppConstants.PROJECT.name}", context: context),
        ),
        actions: [],
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
          Get.find<LocationController>().getLocationList();
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
                        return setBoxesView(context, loc, c);
                      },
                    );
        },
      ),
    );
  }

  setBoxesView(context, Location loc, LocationController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 0),
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
                                        Row(
                                          children: <Widget>[
                                            title_text_grey17head(title: 'Created On ${dateFormat.format(loc.createdOn)}', context: context),
                                            PopupMenuButton<PageEnum>(
                                                onSelected: (PageEnum value) {
                                                  switch (value) {
                                                    case PageEnum.edit:
                                                      Get.to(AddLocation(flag: 1, location: loc));
                                                      break;
                                                    case PageEnum.delete:
                                                      deleteDialog(
                                                          entity: txtLocation,
                                                          function: () {
                                                            Get.back();
                                                            c.deleteLocation(context, loc.id);
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
                                                    ])
                                          ],
                                        ),
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
    bool showSearch = false;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 0, right: 8.0, left: 8.0),
      child: Column(
        children: [
          Row(
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
                      Get.to(AddLocation(flag: 0));
                    },
                  ),
                  TenSizeBoxWidth(),
                  InkWell(
                    child: Icon(
                      CupertinoIcons.search,
                      size: 25,
                    ),
                    onTap: () {
                      setState(() {
                        if (showSearch == true) {
                          showSearch = false;
                        } else {
                          showSearch = true;
                        }
                      });
                    },
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
          if (showSearch == true) new CustomSearchBar()
        ],
      ),
    );
  }
}
