import 'package:flt_imo/Controller/InitialController/projectListController.dart';
import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Screen/AddScreens/addProject.dart';
import 'package:flt_imo/Screen/Drawer/drawer.dart';
import 'package:flt_imo/Screen/InitialScreens/HomeScreen.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/noDataWidget.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

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
                                    return setBoxesView(context, project);
                                  },
                                ),
                    )),
          ),
        ],
      ),
    );
  }

  setBoxesView(context, Project project) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 10,
      ),
      child: InkWell(
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10,
            color: white,
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.5),
              ),
              child: Column(
                children: <Widget>[
                  TenSizeBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${dateFormat.format(project.createdOn)}",
                        style: TextStyle(
                          color: headerTextColor,
                        ),
                      ),
                      PopupMenuButton<PageEnum>(
                          onSelected: (PageEnum value) {
                            switch (value) {
                              case PageEnum.edit:
                                Get.back();
                                Get.to(Get.to(CreateProjects(
                                  1,
                                  project: project,
                                )));
                                break;
                              case PageEnum.delete:
                                Get.back();
                                deleteDialog(
                                    entity: "project",
                                    function: () {
                                      pC.deleteProject(project.id.toString());
                                    });
                                break;
                            }
                          },
                          child: Icon(Icons.more_vert),
                          itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                                PopupMenuItem<PageEnum>(
                                  value: PageEnum.edit,
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem<PageEnum>(
                                  value: PageEnum.delete,
                                  child: Text('Delete'),
                                ),
                              ])
                    ],
                  ),
                  FifteenSizeBox(),
                  "${project.name}".text.bold.minFontSize(30).gray800.make().paddingOnly(top: 16, bottom: 10),
                  "${project.description}".text.xl.italic.gray700.make().paddingOnly(top: 0, bottom: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_city_outlined,
                            color: primaryColor,
                          ),
                          TenSizeBoxWidth(),
                          "Inventory : ${project.inventoriesCount}".text.xl.black.make(),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.storage,
                            color: primaryColor,
                          ),
                          TenSizeBoxWidth(),
                          "Location : ${project.locationsCount}".text.xl.black.make(),
                        ],
                      ),
                    ],
                  ).px(10).py(5),
                  Divider(
                    color: grey,
                    thickness: 3,
                  ).pOnly(bottom: 10),
                  GestureDetector(
                    onTap: () {
                      AppConstants.PROJECT = project;
                      Get.offAll(() => HomeScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: new LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [button, buttonColor],
                        ),
                      ),
                      height: 43,
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          "Enter Project",
                          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TenSizeBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Function onPressed = () {
    Get.to(CreateProjects(0));
  };
}
