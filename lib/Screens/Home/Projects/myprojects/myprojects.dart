import 'package:flt_imo/Comman/app_constants.dart';
import 'package:flt_imo/Controller/ProjectControllers/MyProjectController/myProcjectController.dart';
import 'package:flt_imo/Models/Project/projectListResponse.dart';
import 'package:flt_imo/Screens/Home/Projects/LocationList/locationList.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/10sizebox.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/image_placeHolder.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flt_imo/Widget/pickers.dart';
import 'package:flt_imo/Widget/dialog.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateNewProject/createProject.dart';

class MyProjects extends StatelessWidget {
  // final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: bigTitle_textNormal(title: txtmyProjects, context: context),
        ),
        actions: [
          Container(
            width: 60,
          )
          // IconButton(
          //   icon: Icon(
          //     CupertinoIcons.search,
          //     color: black,
          //   ),
          //   onPressed: () {},
          // ),
          // IconButton(
          //   icon: Icon(
          //     Icons.sort,
          //     color: black,
          //   ),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // setSearchView(context),
              setListView(context),
            ],
          ),
        ),
      ),
    );
  }

  setListView(context) {
    return GetX<MyProjectController>(
      init: Get.put(MyProjectController()),
      initState: (_) {
        Get.find<MyProjectController>().getProjectList();
      },
      builder: (c) {
        return c.isLoading.value
            ? progressIndicator()
            : Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: c.projectListForDisplay.length,
                  itemBuilder: (context, index) {
                    var project = c.projectListForDisplay[index];
                    return setBoxesView(context, project, c);
                  },
                ),
              );
      },
    );
  }

  setBoxesView(context, ProjectList project, c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onLongPress: () {
          editDeleteDailog(() {
            Get.back();
            Get.to(Get.to(CreateProjects(
              1,
              "myprojects",
              project: project,
            )));
          }, () {
            Get.back();
            deleteDialog(
                entity: "project",
                function: () {
                  c.deleteProject(project.id.toString());
                });
          });
        },
        onTap: () {
          AppConstants.PROJECT_ID = project.id.toString();
          Get.to(LocationListScreen(project));
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 50),
              child: Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  color: white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              floatingPlaceHolder(),
                              TenSizeBox(),
                              Container(
                                transform: Matrix4.translationValues(-20, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    bigTitle_textNormalGrey(title: '${project.name}', context: context),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        title_text18Normalbody(title: '${project.inventoriesCount} ', context: context),
                                        title_text18NormalGrey(title: 'Inventories ', context: context),
                                        title_text18Normalbody(title: '${project.locationsCount} ', context: context),
                                        title_text18NormalGrey(title: 'Locations ', context: context),
                                      ],
                                    ),
                                    TenSizeBox(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        title_text_grey16(title: '20 Boxes', context: context),
                                        FifteenSizeBoxWidth(),
                                        FifteenSizeBoxWidth(),
                                        // Spacer(),
                                        title_text16Bold(title: 'Created on ${dateFormat.format(project.createdOn)}', context: context),
                                      ],
                                    ),
                                    TenSizeBox(),
                                  ],
                                ),
                              ),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Container(
            //   child: ImageView(Images.IMAGE_GALLERY, 100, 100),
            // ),
          ],
        ),
      ),
    );
  }

  setSearchView(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(CupertinoIcons.search),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(CupertinoIcons.line_horizontal_3_decrease),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(Icons.sort),
          onPressed: null,
        ),
      ],
    );
  }
}
