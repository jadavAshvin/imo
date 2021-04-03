import 'package:flt_imo/Controller/HomeController/homeController.dart';
import 'package:flt_imo/Screens/Home/Projects/CreateNewProject/createProject.dart';
import 'package:flt_imo/Screens/Home/Projects/myprojects/myprojects.dart';
import 'package:flt_imo/Utils/colors.dart';
import 'package:flt_imo/Utils/strings.dart';
import 'package:flt_imo/Widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectsView extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          SizedBox(
            height: 120,
          ),
          cardView(1, context, txtNew, txtStartNewProject),
          cardView(2, context, txtOpen, txtBrowseExistingProject),
        ],
      )
    ]);
  }

  Widget cardView(int flag, BuildContext context, String title, String description) {
    return InkWell(
      onTap: () {
        if (flag == 1) {
          Get.to(CreateProjects(0, "Home"));
        } else {
          Get.to(MyProjects());
        }
      },
      child: Card(
        elevation: 10,
        color: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 130,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                title_text26NormalBlack(title: title, context: context),
                SizedBox(
                  height: 5,
                ),
                title_text20BoldBlack(title: description, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
