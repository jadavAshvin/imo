import 'package:flt_imo/Controller/InitialController/projectListController.dart';
import 'package:flt_imo/Screen/AddScreens/addProject.dart';
import 'package:flt_imo/Screen/Drawer/drawer.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/noDataWidget.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flt_imo/Screen/Project/projectItem.dart';
import 'package:get/get.dart';

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

final MyProjectController pC = Get.put(MyProjectController());

class _ProjectListScreenState extends State<ProjectListScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double screenHeight;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: grey200,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: onPressed,
        child: Icon(Icons.add),
      ),
      drawer: DrawerOnly(),
      appBar: PreferredSize(
        child: CustomNewAppBar(_scaffoldKey, txtProjects, "0", "", () {
          logoutDialog();
        }, color: grey200),
        preferredSize: Size.fromHeight(100),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: pC.getRefreshData,
            child: GetX<MyProjectController>(
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
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: pC.projectForDisplay.length,
                                  // itemCount: 5,
                                  itemBuilder: (context, index) {
                                    var project = pC.projectForDisplay[index];
                                    return ProjectItemWidget(project: project);
                                  },
                                ),
                    )),
          ),
        ],
      ),
    );
  }

  Function onPressed = () {
    Get.to(CreateProjects(0));
  };
}
