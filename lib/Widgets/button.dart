import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '10sizebox.dart';
import 'decoration.dart';

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
          decoration: boxDecorationWhite(),
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
          decoration: boxDecorationWhite(),
          child: Center(child: CupertinoActivityIndicator()),
        ),
      ),
    );
  }
}

class CalenderButton extends StatelessWidget {
  final double left;
  final double right;
  final Function() onTap;
  final String title;
  final Color color;
  CalenderButton({
    this.title,
    this.left,
    this.right,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45.0,
          padding: EdgeInsets.all(10),
          decoration: new BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            //  border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: Row(
              children: <Widget>[
                Icon(Icons.calendar_today, color: white),
                TenSizeBoxWidth(),
                Text(title, style: Theme.of(context).textTheme.button.copyWith(color: white, fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
