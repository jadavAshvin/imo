
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'imageView.dart';


class CustomNewAppBar extends StatelessWidget {
  final String headerTitle;
  final String rightTitle;
  final String leftCloseIcon;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final Function() _onTap;
  CustomNewAppBar(this._scaffoldKey,this. headerTitle,this. rightTitle,this. leftCloseIcon,this._onTap, );
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 110,
      color: white,
      alignment: Alignment.center,
      child: SafeArea(
        child:  Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _scaffoldKey==null?InkWell(
                onTap: (){
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 10.0,bottom: 5.0,top: 5.0),
                  child:Icon(Icons.arrow_back),
                ),
              ): InkWell(
                onTap: (){
                  _scaffoldKey.currentState.openDrawer();
                },
                child: Container(
                  width: 23,
                  height: 17,
                  child: ImageView(Images.MENU, 20, 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child:
                bigTitle_textNormal(title: headerTitle, context: context),
              ),
              rightTitle!=""? InkWell(
                onTap: _onTap,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 5.0,bottom: 5.0,top: 5.0),
                  child:
                  ImageView(Images.LOGOUT, 20, 20),
                ),
              ):Icon(
                Icons.navigate_before,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


