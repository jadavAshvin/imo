import 'package:flt_imo/Controller/HomeController/homeController.dart';
import 'package:flt_imo/Screens/Drawer/drawer.dart';
import 'package:flt_imo/Screens/Home/TabView/collaborations.dart';
import 'package:flt_imo/Screens/Home/TabView/projects.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/appNewbar.dart';
import 'package:flt_imo/Widget/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'TabView/boxs.dart';
import 'package:flt_imo/Screens/Home/Projects/AddLocation/addLocation.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateInventory/CreateInventory.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController());
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
      backgroundColor: white,
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
              label: "Storage",
              onTap: () {},
              child: Icon(Icons.storage),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
          SpeedDialChild(
              label: "Item Count",
              onTap: () {},
              child: Icon(Icons.countertops_outlined),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
          SpeedDialChild(
              label: "Location",
              onTap: () {
                Get.to(AddLocation(0, "drawer"));
              },
              child: Icon(Icons.location_city_outlined),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
          SpeedDialChild(
              label: "Inventory",
              onTap: () {
                Get.to(CreateInventory(flag: 0, screen: "drawer"));
              },
              child: Icon(Icons.inventory),
              labelStyle: TextStyle(color: white),
              labelBackgroundColor: primaryColor,
              backgroundColor: primaryColor),
        ],
      ),
      drawer: DrawerOnly(),
      appBar: PreferredSize(
        child: CustomNewAppBar(_scaffoldKey, txtProject, "0", "", () {
          logoutDialog();
        }),
        preferredSize: Size.fromHeight(100),
      ),
      body: ListView(
        children: [
          Container(
            child: TabBar(
              unselectedLabelColor: grey,
              labelColor: black,
              indicatorColor: grey,
              labelStyle: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
              controller: _controller,
              tabs: [
                Tab(
                  text: txtProjects,
                ),
                Tab(text: txtBoxes),
                Tab(text: txtCollaborations),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 10,
            ),
            margin: EdgeInsets.only(top: 10.0),
            height: screenHeight * 1.4,
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                ProjectsView(),
                BoxsView(),
                CollaborationsView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
