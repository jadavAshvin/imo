import 'package:flt_imo/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
bigTitle_text({double fontSize, String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: white,
          )
          .copyWith(color: primaryColor, fontSize: fontSize, fontWeight: FontWeight.bold));
}

// ignore: non_constant_identifier_names
bigTitle_blacktext({double fontSize, String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: white,
          )
          .copyWith(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.bold));
}

// ignore: non_constant_identifier_names
bigTitle_textNormal({double fontSize, String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: black,
          )
          .copyWith(color: black, fontSize: 22, fontWeight: FontWeight.w500));
}

// ignore: non_constant_identifier_names
bigTitle_textNormalGrey({double fontSize, String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: black,
          )
          .copyWith(color: grey, fontSize: 22, fontWeight: FontWeight.w500));
}

// ignore: non_constant_identifier_names
bigTitle_textBold({double fontSize, String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: black,
          )
          .copyWith(color: black, fontSize: 20, fontWeight: FontWeight.bold));
}

// ignore: non_constant_identifier_names
title_text_grey12({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: white,
          )
          .copyWith(color: grey, fontSize: 12));
}

// ignore: non_constant_identifier_names
title_text_white12({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: white,
          )
          .copyWith(color: white, fontSize: 12));
}

// ignore: non_constant_identifier_names
title_text_white14({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: white,
          )
          .copyWith(color: white, fontSize: 14));
}

// ignore: non_constant_identifier_names
title_text_black14({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(
            color: white,
          )
          .copyWith(color: black, fontSize: 14));
}

// ignore: non_constant_identifier_names
title_text_black16({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(
            color: white,
          )
          .copyWith(color: black, fontSize: 16));
}

// ignore: non_constant_identifier_names
title_text_grey14({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .headline2
          .copyWith(
            color: black,
          )
          .copyWith(color: black, fontSize: 14));
}

// ignore: non_constant_identifier_names
title_text_grey16({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .headline2
          .copyWith(
            color: black,
          )
          .copyWith(color: black, fontSize: 16));
}

// ignore: non_constant_identifier_names
title_text_black16bold({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context).textTheme.headline2.copyWith(color: black, fontWeight: FontWeight.bold).copyWith(color: black, fontSize: 16));
}

// ignore: non_constant_identifier_names
title_text_white16bold({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context).textTheme.headline2.copyWith(color: white, fontWeight: FontWeight.bold).copyWith(color: white, fontSize: 16));
}

// ignore: non_constant_identifier_names
title_text18Normalbody({String title, BuildContext context}) {
  return Text(title, style: Theme.of(context).textTheme.bodyText1.copyWith(color: white, fontSize: 18));
}

// ignore: non_constant_identifier_names
title_text18Normal({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 18, color: black));
}

// ignore: non_constant_identifier_names
title_text18NormalGrey({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(
            fontWeight: FontWeight.w300,
            color: white,
          )
          .copyWith(color: black, fontSize: 18));
}

// ignore: non_constant_identifier_names
title_text18NormalWhite({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 18, color: black));
}

Widget textFieldTitle({double fontSize, String title}) {
  return Text(
    title,
    style: TextStyle(fontSize: fontSize, color: subTitleColor, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

// ignore: non_constant_identifier_names
title_text18Bold({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black));
}

// ignore: non_constant_identifier_names
title_text16Bold({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: black));
}

// ignore: non_constant_identifier_names
title_text20BoldWhite({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white));
}

// ignore: non_constant_identifier_names
title_text26NormalBlack({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 26, color: black));
}

// ignore: non_constant_identifier_names
title_text20NormalWhite({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 20, color: white));
}

// ignore: non_constant_identifier_names
title_text20BoldBlack({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black));
}

// ignore: non_constant_identifier_names
title_text20NormalBlack({String title, BuildContext context}) {
  return Text(title, style: TextStyle(fontSize: 20, color: black));
}

// ignore: non_constant_identifier_names
title_text_grey11({String title, BuildContext context}) {
  return Text(title,
      style: Theme.of(context)
          .textTheme
          .button
          .copyWith(
            color: white,
          )
          .copyWith(color: grey, fontSize: 11.0));
}

// ignore: non_constant_identifier_names
title_text_grey13({String title, BuildContext context}) {
  return Text(title, style: Theme.of(context).textTheme.button.copyWith().copyWith(color: grey, fontSize: 13.0));
}

// ignore: non_constant_identifier_names
title_text_grey17head({String title, BuildContext context}) {
  return Text(title, style: Theme.of(context).textTheme.bodyText2.copyWith().copyWith(color: grey, fontSize: 17.0, fontWeight: FontWeight.w300));
}

// ignore: non_constant_identifier_names
title_text_black13({String title, BuildContext context}) {
  return Text(title, style: Theme.of(context).textTheme.button.copyWith().copyWith(color: black, fontSize: 13.0));
}
