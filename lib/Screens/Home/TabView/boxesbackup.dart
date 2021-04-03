import 'package:flt_imo/Controller/HomeController/homeController.dart';
import 'package:flt_imo/Controller/TabBar/boxesController.dart';
import 'package:flt_imo/Screens/Home/Projects/PrintQr/printQr.dart';
import 'package:flt_imo/Screens/Home/Projects/addBox/addBox.dart';
import 'package:flt_imo/Screens/Home/Projects/collaborators/collaborators.dart';
import 'package:flt_imo/Screens/Home/Projects/collaborators/sharescreen.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/image_placeHolder.dart';
import 'package:flt_imo/Widget/noDataWidget.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxsView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            setSearchView(context),
            setListView(context),
          ],
        ),
      ),
    );
  }

  setListView(context) {
    return Container(
      child: GetX<BoxesController>(
        init: Get.put(BoxesController()),
        initState: (_) {
          Get.find<BoxesController>().getBoxesList();
        },
        builder: (c) {
          return c.isLoading.value
              ? progressIndicator()
              : c.boxListForDisplay.isEmpty
                  ? noDataWidget(txtBoxes)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: c.boxListForDisplay.length,
                      itemBuilder: (context, index) {
                        return setBoxesView(context);
                      },
                    );
        },
      ),
    );
  }

  setBoxesView(context) {
    return InkWell(
      onTap: () {
        Get.to(AddBoxes(
          flag: 1,
          screen: "BoxesView",
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 50),
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                  elevation: 5,
                  color: white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                              floatingPlaceHolder(),
                              Container(
                                transform: Matrix4.translationValues(-20, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    bigTitle_textNormalGrey(title: 'Mobile Set', context: context),
                                    TenSizeBox(),
                                    title_text20NormalBlack(title: '28 Items', context: context),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  title_text18Normal(title: '05-10-2021', context: context),
                                  TenSizeBox(),
                                  Row(
                                    children: <Widget>[
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
                              TenSizeBoxWidth()
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(Collaborators());
                            },
                            child: Container(
                              transform: Matrix4.translationValues(0, 15, 0),
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  title_text_white14(title: 'Shared with 5 others', context: context),
                                  title_text_white14(title: "Public", context: context),
                                ],
                              ),
                            ),
                          ),
                        ],
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
      ),
    );
  }

  setSearchView(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {},
        ),
      ],
    );
  }
}
