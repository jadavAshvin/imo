import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/decorationConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double left;
  final double right;
  final Function() onTap;
  final String title;
  CustomButton(
    this.title,
    this.left,
    this.right,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50.0,
          decoration: boxDecorationButton(),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonProgress extends StatelessWidget {
  final double left;
  final double right;

  CustomButtonProgress(
    this.left,
    this.right,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        child: Container(
          height: 50.0,
          decoration: boxDecorationButton(),
          child: Center(child: CupertinoActivityIndicator()),
        ),
      ),
    );
  }
}
