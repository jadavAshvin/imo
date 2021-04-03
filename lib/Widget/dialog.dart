import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Comman/keys.dart';
import 'package:flt_imo/Screens/Login/login.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

logoutDialog() {
  Get.dialog(
    AlertDialog(
      title: Text(txtAreYouSureLogout),
      //content: Text("This should not be closed automatically"),
      actions: <Widget>[
        TextButton(
          child: Text(txtYes),
          onPressed: () {
            Get.back();
            setPrefValue(Keys.AUTH_TOKEN, "");
            setPrefValue(Keys.ACCESS_TOKEN, "");
            setPrefValue(Keys.REFRESH_TOKEN, "");
            Get.offAll(Login());
          },
        ),
        TextButton(
          child: Text(txtNo),
          onPressed: () {
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}

editDeleteDailog(onChangedEdit, onChangedDelete) {
  Get.defaultDialog(
    radius: 5,
    title: '',
    titleStyle: TextStyle(fontSize: 1),
    content: Container(
      width: Get.width - 50,
      child: Column(
        children: <Widget>[
          CustomButton('Edit', 0, 0, onChangedEdit),
          FifteenSizeBox(),
          CustomButton('Delete', 0, 0, onChangedDelete),
        ],
      ),
    ).paddingAll(10),
  );
}

deleteDialog({entity, function}) {
  Get.dialog(
    AlertDialog(
      title: Text('Are you sure you want to delete ${entity.toString().toLowerCase()}?'),
      //content: Text("This should not be closed automatically"),
      actions: <Widget>[
        TextButton(
          child: Text(txtYes),
          onPressed: function,
        ),
        TextButton(
          child: Text(txtNo),
          onPressed: () {
            Get.back(result: false);
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}
