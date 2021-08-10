import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flt_imo/Controller/InitialController/projectListController.dart';
import 'package:flt_imo/Screen/AddScreens/addProject.dart';
import 'package:flt_imo/Screen/Auth/profile.dart';
import 'package:flt_imo/Screen/Drawer/drawer.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/noDataWidget.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Screen/Project/projectItem.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:velocity_x/velocity_x.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

final MyProjectController pC = Get.put(MyProjectController());

class _ProjectListScreenState extends State<ProjectListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double? screenHeight;
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: pC.bannerAd!);

    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: grey200,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: onPressed as void Function()?,
        child: Icon(Icons.add),
      ),
      drawer: DrawerOnly(),
      appBar: PreferredSize(
        child: CustomNewAppBar(
          null,
          txtProjects,
          "0",
          "",
          () {
            logoutDialog();
          },
          color: grey200,
          front: "",
        ),
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
          Icon(Icons.person, color: white),
        ],
      ),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: [
              projectList(adWidget),
              Profile(),
            ][index],
          )
        ],
      ),
    );
  }

  projectList(adWidget) {
    return RefreshIndicator(
      onRefresh: pC.getRefreshData,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: Container(
                  alignment: Alignment.center,
                  child: adWidget,
                  width: MediaQuery.of(context).size.width.toDouble(),
                  height: pC.bannerAd!.size.height.toDouble(),
                )),
            FifteenSizeBox(),
            GetX<MyProjectController>(
              init: MyProjectController(),
              initState: (state) {
                pC.getProject();
              },
              builder: (c) => Container(
                child: pC.isLoading.value
                    ? progressIndicator()
                    : pC.projectForDisplay.isEmpty
                        ? noDataWidget(txtProject)
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: pC.projectForDisplay.length,
                            // itemCount: 5,
                            itemBuilder: (context, index) {
                              var project = pC.projectForDisplay[index];
                              return ProjectItemWidget(project: project);
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Function onPressed = () {
    Get.to(CreateProjects(0));
  };
}
