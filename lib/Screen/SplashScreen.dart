import 'dart:async';

import 'package:flt_imo/Controller/GeneralController/accessController.dart';
import 'package:flt_imo/Screen/Auth/login.dart';
import 'package:flt_imo/Screen/InitialScreens/projectList.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Models/loginResponseModel.dart';
import 'package:flt_imo/Service/userService.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  silentLogin() {
    if (getPrefValue(Keys.REFRESH_TOKEN) != "") {
      var body = {"userId": getPrefValue(Keys.USER_ID), "refreshToken": getPrefValue(Keys.REFRESH_TOKEN)};
      silentLoginApi(body).then((response) {
        if (response.statusCode == 200) {
          var l = loginResponseFromJson(response.body);
          setPrefValue(Keys.AUTH_TOKEN, l.tokens.idToken.toString());
          setPrefValue(Keys.ACCESS_TOKEN, l.tokens.accessToken.toString());
          // setPrefValue(Keys.REFRESH_TOKEN, l.tokens.refreshToken.toString());
          setPrefValue(Keys.USER_ID, l.userId.toString());
        } else {
          setPrefValue(Keys.AUTH_TOKEN, "");
          setPrefValue(Keys.ACCESS_TOKEN, "");
          setPrefValue(Keys.REFRESH_TOKEN, "");
          Get.offAll(Login());
        }
      });
    } else {
      print("user is logout");
    }
  }

  @override
  void initState() {
    super.initState();
    Pref.init();
    Get.lazyPut(() => AccessController(), fenix: true);
    Get.find<AccessController>().checkOnline();
    Future.delayed(Duration(seconds: 1), () {
      silentLogin();
    });

    Timer.periodic(Duration(seconds: 3480), (Timer t) => silentLogin());
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      if (getPrefValue(Keys.AUTH_TOKEN).isNotEmpty) {
        Get.offAll(ProjectListScreen());
      } else {
        Get.offAll(Login());
      }
    });
    return Scaffold(
      body: Center(
        child: Text(
          "IMO",
          style: TextStyle(color: Colors.blue, fontSize: 120),
        ),
      ),
    );
  }
}
