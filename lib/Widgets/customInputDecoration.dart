/*
import 'package:Proctor/Controller/AdminController/addFormController.dart';
import 'package:Proctor/Screens/Widget/text.dart';
import 'package:Proctor/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommanTextField extends StatelessWidget {
  final AddFormController addFormController = Get.put(AddFormController());

  final TextInputType keyboardType;
  final TextEditingController controller;
  final String labelName;
  final int flag;
  final bool password;
  CommanTextField(
    this.keyboardType,
    this.controller,
    this.labelName,
    this.flag,
    this.password,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        child: TextFormField(
          style: Theme.of(context).textTheme.subtitle2,
          keyboardType: keyboardType,
          obscureText: password ? true : false,
          controller: controller,
          textInputAction: flag == 1 ? TextInputAction.next : TextInputAction.done,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(width: 1), borderRadius: BorderRadius.all(Radius.circular(5.0))),
            labelText: labelName,
          ),
          onFieldSubmitted: (_) => flag == 1 ? addFormController.focus.nextFocus() : addFormController.focus.unfocus(),
          onChanged: (text) {},
        ));
  }
}

class CustomTabWithIcon extends StatelessWidget {
  final icon;
  final title;
  final onTap;

  CustomTabWithIcon({Key key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: grey),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left:8),
            child:title_text12Grey(context: context, title: title),
            ),
            Icon(
              icon,
              color: grey,
            )
          ],
        ),
      ),
    );
  }
}
*/
