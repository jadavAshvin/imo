import 'package:flt_imo/Controller/HomeController/homeController.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/image_placeHolder.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KitchenScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: black,
          ),
          onPressed: () {},
        ),
        title: Center(
          child: bigTitle_textNormal(title: txtkithcen, context: context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: black,
            ),
            onPressed: () {},
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
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return setBoxesView(context);
        },
      ),
    );
  }

  setBoxesView(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
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
                                  bigTitle_textNormalGrey(title: 'Inventory Items', context: context),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TenSizeBox(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      title_text16Bold(title: '20 Boxes', context: context),
                                      FifteenSizeBoxWidth(),
                                      FifteenSizeBoxWidth(),
                                      // Spacer(),
                                      title_text_grey16(title: 'Created on 05-June-1998', context: context),
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
                onTap: () {},
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
