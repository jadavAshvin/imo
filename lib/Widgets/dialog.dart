import 'package:flt_imo/Screen/Auth/login.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/strings.dart';
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
            Get.back();
          },
        )
      ],
    ),
    barrierDismissible: false,
  );
}
