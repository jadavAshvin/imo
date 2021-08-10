import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Screen/AddScreens/addProject.dart';
import 'package:flt_imo/Screen/InitialScreens/HomeScreen.dart';
import 'package:flt_imo/Screen/InitialScreens/projectList.dart';
import 'package:flt_imo/Utils/app_constants.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Widgets/10sizebox.dart';
import 'package:share/share.dart';
import 'package:flt_imo/Widgets/dialog.dart';
import 'package:flt_imo/Widgets/pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProjectItemWidget extends StatelessWidget {
  final Project project;

  const ProjectItemWidget({Key? key, required this.project}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  InkWell(
                    onTap: () {
                      AppConstants.PROJECT = project;
                      Get.to(() => HomeScreen());
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "${dateFormat.format(project.createdOn!)}",
                                style: TextStyle(
                                  color: headerTextColor,
                                ),
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: project.isOwner! ? Colors.green : Colors.orange, borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                  child: Text(
                                    "${project.access}",
                                    style: TextStyle(color: white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              // PopupMenuButton<PageEnum>(
                              //     onSelected: (PageEnum value) {
                              //       switch (value) {
                              //         case PageEnum.edit:
                              //           Get.back();
                              //           Get.to(CreateProjects(
                              //             1,
                              //             project: project,
                              //           ));
                              //           break;
                              //         case PageEnum.delete:
                              //           Get.back();
                              //           deleteDialog(
                              //               entity: "project",
                              //               function: () {
                              //                 pC.deleteProject(project.id.toString());
                              //               });
                              //           break;
                              //       }
                              //     },
                              //     child: Icon(Icons.more_vert),
                              //     itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                              //           PopupMenuItem<PageEnum>(
                              //             value: PageEnum.edit,
                              //             child: Text('Edit'),
                              //           ),
                              //           PopupMenuItem<PageEnum>(
                              //             value: PageEnum.delete,
                              //             child: Text('Delete'),
                              //           ),
                              //         ])
                            ],
                          ),
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
                          TenSizeBox(),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     InkWell(
                  //       borderRadius: BorderRadius.circular(10),
                  //       onTap: () {
                  //         Share.share('Connect To my project using this link', subject: 'Project Connection');
                  //       },
                  //       child: Icon(
                  //         Icons.share,
                  //         color: greyDark,
                  //       ),
                  //     ),
                  //     InkWell(
                  //       borderRadius: BorderRadius.circular(10),
                  //       onTap: () {
                  //         Get.to(CreateProjects(
                  //           1,
                  //           project: project,
                  //         ));
                  //       },
                  //       child: Icon(
                  //         Icons.edit,
                  //         color: greyDark,
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         deleteDialog(
                  //             entity: "project",
                  //             function: () {
                  //               pC.deleteProject(project.id.toString());
                  //             });
                  //       },
                  //       child: Icon(
                  //         CupertinoIcons.delete,
                  //         color: greyDark,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  TenSizeBox(),
                  Divider(
                    color: grey,
                    thickness: 3,
                  ).pOnly(bottom: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Share.share('Connect To my project using this link', subject: 'Project Connection');
                        },
                        child: Icon(
                          Icons.share,
                          color: greyDark,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          AppConstants.PROJECT = project;
                          Get.to(CreateProjects(
                            1,
                            project: project,
                          ));
                        },
                        child: Icon(
                          Icons.edit,
                          color: greyDark,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          deleteDialog(
                              entity: "project",
                              function: () {
                                pC.deleteProject(project.id.toString());
                              });
                        },
                        child: Icon(
                          CupertinoIcons.delete,
                          color: greyDark,
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  // AppConstants.PROJECT = project;
                  // Get.offAll(() => HomeScreen());
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       gradient: new LinearGradient(
                  //         begin: Alignment.topRight,
                  //         end: Alignment.topLeft,
                  //         colors: [button, buttonColor!],
                  //       ),
                  //     ),
                  //     height: 43,
                  //     padding: EdgeInsets.all(2),
                  //     child: Center(
                  //       child: Text(
                  //         "Enter Project",
                  //         style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  TenSizeBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
