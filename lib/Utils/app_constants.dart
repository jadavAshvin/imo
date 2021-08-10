import 'dart:io';

import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Utils/pref.dart';

import 'keys.dart';

enum PageEnum {
  edit,
  delete,
}

class AppConstants {
  // ignore: non_constant_identifier_names
  static Project PROJECT = Project();
  // ignore: non_constant_identifier_names
  static String EMAIL_VERIFY = "";
  // ignore: non_constant_identifier_names
  static String PHONE_VERIFY = "";
  // ignore: non_constant_identifier_names
  static String LAT = "";
  // ignore: non_constant_identifier_names
  static String LONG = "";
  // ignore: non_constant_identifier_names
  static String? ADDRESS = "";

/*
  static const String NATIONALID = "NATIONALID";
  static const String MRNNO = "MRNNO";
  static const String FIRTSNAME= "FIRTSNAME";
  static const String LASTNAME= "LASTNAME";
  static const String MOBILENO= "MOBILENO";

  static const String DELIVERYADDRESS= "DELIVERYADDRESS";
  static const String WAYNO= "WAYNO";
  static const String STREETNAME= "STREETNAME";
  static const String BUILDING = "BUILDING";
  static const String PLOTNO = "PLOTNO";
  static const String GOVERNORATE = "GOVERNORATE";
  static const String NEARESTLANDMARK = "NEARESTLANDMARK";
  static String NATIONALID = "";
  static String MRNNO = "";
  static String FIRTSNAME = "";
  static String NAME = "";
  static String LASTNAME = "";
  static String MOBILENO = "";

  static String DELIVERYADDRESS = "";
  static String WAYNO = "";
  static String STREETNAME = "";
  static String BUILDING = "";
  static String PLOTNO = "";
  static String GOVERNORATE = "";
  static String NEARESTLANDMARK = "";
  static String ORDER_NO = "";
  static String ORDER_DATE = "";
  static String City_Name = "";
  static String PHARMACYID = "";
  static String HOME_CLICK = "";*/
}

storeAppConstant() {
  AppConstants.PROJECT = Project();
}

/*String getPrefValue(String key) {
  return Pref.getString(key, "");
}*/

String getLabel(String key) {
  return Pref.getString(key, "Empty");
}

setLabel(String key, String value) async {
  await Pref.setString(key, value);
}

String removeLastCar(String str) {
  if (str == '') return "";
  return str.substring(1, str.length - 1);
}

/*String getToken(String key) {
  return "Bearer " + Pref.getString(key, "");
}*/

setLog(String param, String url, String body) {
  print("PARAM : $param");
  print("URL : $url");
  print("RESPONSE : $body");
}

setSingleLog(String msg) {
  print(msg);
}

/*setPrefValue(key, value) {
  Pref.setString(key, value);
}

setPrefArrayValue(key, List) {
  Pref.setString(key, List);
}*/

String firstCarCap(value) {
  return '${value[0].toUpperCase()}${value.substring(1)}';
}

/*String validEmail(value, key) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return getPrefValue(key);
  else
    return null;
}*/

clearAllData() {
  setPrefValue(Keys.EMAIL, "");
  setPrefValue(Keys.CUSTOMERID, "");
  setPrefValue(Keys.AUTH_TOKEN, "");
  setPrefValue(Keys.USER_ID, "");
  AppConstants.PROJECT = Project();
  /*
  AppConstants.NAME = "";
  AppConstants.LASTNAME = "";
  AppConstants.DELIVERYADDRESS = "";
  AppConstants.WAYNO = "";
  AppConstants.STREETNAME = "";
  AppConstants.BUILDING = "";
  AppConstants.PLOTNO = "";
  AppConstants.NEARESTLANDMARK = "";*/
}

setPrefValue(key, value) {
  Pref.setString(key, value);
}

String getPrefValue(String key) {
  return Pref.getString(key, "");
}

getPlatform() {
  return Platform.isIOS ? '2' : '1';
}

String? validateMobile(String value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    //  return toast("Mobile number required", 2);
  } else if (!regExp.hasMatch(value)) {
    //  return toast("Enter valid mobile number", 2);
  }
  return null;
}

/*
checkInternet(BuildContext context) async {
  if (await isConnected(context)) {}
}
*/

/*Future<bool> isConnected(BuildContext context) async {
  try {
  */ /*  String url = "https://www.google.com/";
    Response response = await get(url);
    int statusCode = response.statusCode;
    String body = response.body;
    //  print("I am connected");
    if (statusCode == 200) {
      // print("Success connected");
      return true;
    } else {
      //navigateToNoInternet(context);
      return true;
    }*/ /*
  } on SocketException catch (_) {
    print("Success not connected error11 ${_}");
    Get.back();
    Get.to(NoInternet());
    return false;
  } catch (val) {
    */ /*   Fluttertoast.showToast(
        msg: "Please Check Your Internet Connection",
        toastLength: Toast.LENGTH_LONG);*/ /*
    return false;
  }
}*/
