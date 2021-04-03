import 'dart:io';
import 'package:flt_imo/Controller/accessController.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/mySnackbar.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:get/get.dart';
// import 'package:open_settings/open_settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  void initState() {
    super.initState();

    /*  Future.delayed(Duration(seconds: 2), () {
      OpenSettings.openMobileDataSetting();

    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 200.0),
              Container(
                height: 150.0,
                width: 150.0,
                child: Lottie.asset(
                  Images.no_internet_connection,
                  repeat: false,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                txtWhoops,
                style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Text(
                  txtCheckInternet,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0),
                ),
              ),
              SizedBox(height: 30.0),
              InkWell(
                onTap: () {
                  Get.find<AccessController>().checkOnline();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    child: Center(
                      child: Text(
                        txtRetry,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.normal, fontSize: 16.0),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: missing_return
Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
  } on SocketException catch (_) {
    print('not connected');
    mySnackbar(title: 'Not Connected', description: 'Please check your internet Connection');
    return false;
  }
}
// // ignore: missing_return
// Future<bool> isConnected() async {
//   try {
//     // ignore: unused_local_variable
//     String url = "https://www.google.com/";
//     http.Response response = await http.get(url);
//     int statusCode = response.statusCode;

//     //  print("I am connected");
//     if (statusCode == 200) {
//       print("Success connected");
//       Get.back();
//       return true;
//     } else {
//       //navigateToNoInternet(context);
//       return true;
//     }
//   } on SocketException catch (_) {
//     // OpenSettings.openMobileDataSetting();
//     Get.to(NoInternet());
//     print("Success not connected error11 $_");
//     return false;
//   } catch (val) {
//     /*   Fluttertoast.showToast(
//         msg: "Please Check Your Internet Connection",
//         toastLength: Toast.LENGTH_LONG);*/
//     return false;
//   }
// }
