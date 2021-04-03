import 'package:flt_imo/Controller/ProjectControllers/CreateProjectController/createProjectController.dart';
import 'package:flt_imo/Models/Project/projectListResponse.dart';
import 'package:flt_imo/Screens/Drawer/drawer.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/20sizebox.dart';
import 'package:flt_imo/Widget/appNewbar.dart';
import 'package:flt_imo/Widget/button.dart';
import 'package:flt_imo/Widget/progressIndicator.dart';
import 'package:flt_imo/Widget/textStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProjects extends StatelessWidget {
  final flag;
  final screen;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ProjectList project;
  CreateProjects(this.flag, this.screen, {this.project});
  // final CreateProjectController createProjectController = Get.put(CreateProjectController());
  @override
  Widget build(BuildContext context) {
    return screen == "drawer"
        ? Scaffold(
            drawer: DrawerOnly(
              module: "AddLocation",
            ),
            key: _scaffoldKey,
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(_scaffoldKey, flag == 0 ? txtCreateProject : txtEditProject, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: GetX<CreateProjectController>(
                init: CreateProjectController(),
                initState: (_) {
                  if (flag == 1) {
                    Get.find<CreateProjectController>().setParam(project);
                  }
                },
                builder: (c) {
                  return c.isDetailLoading.value
                      ? progressIndicator()
                      : ListView(
                          children: [
                            setImageView(context, c),
                            setTextFieldView(context, c),
                            FifteenSizeBox(),
                            FifteenSizeBox(),
                            Obx(() => c.processLoading.value
                                ? CustomButtonProgress(0, 0)
                                : CustomButton(txtCreateProject, 0, 0, () {
                                    c.addBtn(flag, false);
                                  })),
                          ],
                        );
                },
              ),
            ),
          )
        : Scaffold(
            backgroundColor: white,
            appBar: PreferredSize(
              child: CustomNewAppBar(null, flag == 0 ? txtCreateProject : txtEditProject, "", "", () {}),
              preferredSize: Size.fromHeight(100),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: GetX<CreateProjectController>(
                init: CreateProjectController(),
                initState: (_) {
                  if (flag == 1) {
                    Get.find<CreateProjectController>().setParam(project);
                  }
                },
                builder: (c) {
                  return c.isDetailLoading.value
                      ? progressIndicator()
                      : ListView(
                          children: [
                            setImageView(context, c),
                            setTextFieldView(context, c),
                            FifteenSizeBox(),
                            FifteenSizeBox(),
                            Obx(() => c.processLoading.value
                                ? CustomButtonProgress(0, 0)
                                : CustomButton(flag == 0 ? txtCreateProject : txtUpdateProject, 0, 0, () {
                                    c.addBtn(flag, true);
                                  })),
                          ],
                        );
                },
              ),
            ),
          );
  }

  Widget setImageView(BuildContext context, CreateProjectController c) {
    return Container(
      height: 240,
      child: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            width: double.infinity,
            height: 220,
            child: Obx(() {
              print("image path is ${c.imageFile.value}");
              return Stack(
                children: [
                  c.imageFile.value.path == ''
                      ? Center(
                          child: Container(
                              child: SizedBox(
                                  child: Image.asset(
                            Images.IMAGE_GALLERY,
                            height: 80,
                            width: 80,
                            color: grey,
                          ))),
                        )
                      : Image.file(
                          c.imageFile.value,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                ],
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                c.cameraAction(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                color: Colors.grey[300],
                height: 40,
                width: 45,
                child: Icon(
                  Icons.camera_alt,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setTextFieldView(BuildContext context, CreateProjectController c) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            // decoration: boxDecoration(),
            child: TextFormField(
              controller: c.projectNameController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtEnterProjectName,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            // decoration: boxDecoration(),
            child: TextField(
              maxLines: null,
              controller: c.descriptionController,
              style: textFieldStyle20(),
              //  onEditingComplete: () => loginController.focus.unfocus(),
              decoration: InputDecoration(
                //  border: InputBorder.none,
                hintText: txtDescription,
              ),
              textInputAction: TextInputAction.newline,
            ),
          ),
        ],
      ),
    );
  }
}
