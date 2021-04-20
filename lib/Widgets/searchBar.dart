import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommanSearchBar extends StatelessWidget {
  final controller;
  final onChanged;
  final searchText;
  CommanSearchBar({Key key, this.controller, this.onChanged, this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      // color: primaryColor,
      child: Container(
        padding: EdgeInsets.only(top: 0),
        // height: 40.0.toHeight(),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(width: 1, color: grey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: TextFormField(
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 16),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: searchText == null ? txtSearch : searchText,
            contentPadding: EdgeInsets.only(top: 0, bottom: 8),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
            enabledBorder: InputBorder.none,
          ),
          onChanged: onChanged,
        ).paddingOnly(left: 10),
      ).paddingOnly(top: 10, bottom: 10, left: 5, right: 5),
    );
  }
}
