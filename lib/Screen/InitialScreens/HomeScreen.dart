import 'package:flt_imo/Screen/AddScreens/addBox.dart';
import 'package:flt_imo/Screen/AddScreens/addBoxItem.dart';
import 'package:flt_imo/Screen/AddScreens/addInventory.dart';
import 'package:flt_imo/Screen/AddScreens/addLocation.dart';
import 'package:flt_imo/Screen/Drawer/drawer.dart';
import 'package:flt_imo/Screen/TabViewScreen/BoxView.dart';
import 'package:flt_imo/Screen/TabViewScreen/dashboardView.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
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
  double screenHeight;
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: grey200,
      key: _scaffoldKey,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        foregroundColor: white,
        backgroundColor: primaryColor,
        renderOverlay: false,
        overlayColor: Colors.transparent,
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
        child: CustomNewAppBar(
          _scaffoldKey,
          txtProject,
          "0",
          "",
          () {
            logoutDialog();
          },
          color: grey200,
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 50),
            margin: EdgeInsets.only(top: 10.0),
            height: screenHeight * 1.4,
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                DashboardView(),
                BoxView(),
                Container(),
              ],
            ),
          ),
          Container(
            child: TabBar(
              unselectedLabelColor: grey,
              labelColor: black,
              indicatorColor: primaryColor,
              labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
              controller: _controller,
              tabs: [
                Tab(text: txtDashboard),
                Tab(text: txtBoxes),
                Tab(text: txtCollaborations),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
