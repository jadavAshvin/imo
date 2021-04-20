import 'package:flt_imo/Controller/AddScreensController/addProjectController.dart';
import 'package:flt_imo/Models/projectModel.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/images.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widgets/20sizebox.dart';
import 'package:flt_imo/Widgets/appNewbar.dart';
import 'package:flt_imo/Widgets/buttonWidget.dart';
import 'package:flt_imo/Widgets/progressIndicator.dart';
import 'package:flt_imo/Widgets/textStyles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProjects extends StatelessWidget {
  final flag;

  final Project project;
  CreateProjects(this.flag, {this.project});
  // final CreateProjectController createProjectController = Get.put(CreateProjectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      SizedBox(
                        height: 240,
                      ),
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
