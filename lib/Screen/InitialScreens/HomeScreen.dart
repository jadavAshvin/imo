import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flt_imo/Screen/AddScreens/addBox.dart';
import 'package:flt_imo/Screen/AddScreens/addBoxItem.dart';
import 'package:flt_imo/Screen/AddScreens/addInventory.dart';
import 'package:flt_imo/Screen/AddScreens/addLocation.dart';
import 'package:flt_imo/Screen/Drawer/drawer.dart';
import 'package:flt_imo/Screen/TabViewScreen/BoxView.dart';
import 'package:flt_imo/Screen/TabViewScreen/dashboardView.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late double screenHeight;
  int index = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: grey200,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        foregroundColor: white,
        backgroundColor: primaryColor,
        renderOverlay: false,
        overlayColor: grey200,
        activeIcon: Icons.close,
        // animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              label: "Item",
              onTap: () {
                Get.to(AddBoxItem(flag: 0));
              },
              child: Icon(Icons.all_inbox_rounded),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
          SpeedDialChild(
              label: "Storage Box",
              onTap: () {
                Get.to(AddBox(flag: 0));
              },
              child: Icon(Icons.inventory),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
          SpeedDialChild(
              label: "Inventory",
              onTap: () {
                Get.to(AddInventory(flag: 0));
              },
              child: Icon(Icons.storage),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
          SpeedDialChild(
              label: "Location",
              onTap: () {
                Get.to(AddLocation(flag: 0));
              },
              child: Icon(Icons.location_city_outlined),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
        ],
      ),
      drawer: DrawerOnly(),
      appBar: PreferredSize(
        child: CustomNewAppBar(null, AppConstants.PROJECT.name!, "0", "", () {
          logoutDialog();
        }, color: grey200),
        preferredSize: Size.fromHeight(100),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,
        buttonBackgroundColor: primaryColor,
        height: 60,
        index: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          Icon(Icons.home, color: white),
          Icon(Icons.inventory, color: white),
          Icon(Icons.people, color: white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: [
            DashboardView(),
            BoxView(),
            Container(),
          ][index],
        ),
      ),
    );
  }
}
