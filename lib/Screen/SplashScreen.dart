import 'dart:async';

import 'package:flt_imo/Controller/GeneralController/accessController.dart';
import 'package:flt_imo/Screen/Auth/login.dart';
import 'package:flt_imo/Screen/InitialScreens/projectList.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/keys.dart';
import 'package:flt_imo/Utils/pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Pref.init();
    Get.lazyPut(() => AccessController(), fenix: true);
    Get.find<AccessController>().checkOnline();
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
