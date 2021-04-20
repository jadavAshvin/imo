// import 'package:flt_imo/Models/Project/projectListResponse.dart';
// import 'package:flt_imo/Utils/Apis/projectApis.dart';
// import 'package:flt_imo/Utils/strings.dart';
// import 'package:flt_imo/Widget/progressIndicator.dart';
// import 'package:flt_imo/Widget/text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProjectDailogController extends GetxController {
//   List<ProjectList> projectList = List<ProjectList>.empty(growable: true);
//   var isproLoading = true.obs;
//   var hasValue = false.obs;
//   getProjectList() async {
//     isproLoading(true);
//     await projectListApi().then((response) {
//       if (response.statusCode == 200) {
//         projectList = projectListFromJson(response.body);
//       } else {
//         projectList = [];
//       }
//     });
//     isproLoading(false);
//   }
// }

// projectDailog() {
//   return Get.defaultDialog(
//     title: txtSelectProject,
//     content: Container(
//       width: Get.width / 1.25,
//       height: Get.height / 5,
//       child: GetX<ProjectDailogController>(
//         init: Get.put(ProjectDailogController()),
//         initState: (_) {
//           Get.find<ProjectDailogController>().getProjectList();
//         },
//         builder: (c) {
//           return c.isproLoading.value
//               ? progressIndicator()
//               : c.projectList.isEmpty
//                   ? Center(child: Text("No project available"))
//                   : ListView.separated(
//                       itemCount: c.projectList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onTap: () {
//                             Get.back(result: c.projectList[index]);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(8.0),
//                             child: title_text20NormalBlack(title: c.projectList[index].name, context: context),
//                           ),
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Divider();
//                       },
//                     );
//         },
//       ),
//     ),
//   );
// }

// Future<ProjectList> projectBottom() async {
//   return Get.bottomSheet(
//     Container(
//       width: Get.width / 1.25,
//       height: Get.height / 3,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 45.0, left: 10, right: 10),
//             child: GetX<ProjectDailogController>(
//               init: Get.put(ProjectDailogController()),
//               initState: (_) {
//                 Get.find<ProjectDailogController>().getProjectList();
//               },
//               builder: (c) {
//                 return c.isproLoading.value
//                     ? progressIndicator()
//                     : c.projectList.isEmpty
//                         ? Center(child: Text("No project available"))
//                         : ListView.separated(
//                             itemCount: c.projectList.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return InkWell(
//                                 onTap: () {
//                                   Get.back(result: c.projectList[index]);
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: title_text20NormalBlack(title: c.projectList[index].name, context: context),
//                                 ),
//                               );
//                             },
//                             separatorBuilder: (BuildContext context, int index) {
//                               return Divider();
//                             },
//                           );
//               },
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: const Color(0xff7687a2),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
