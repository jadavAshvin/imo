// import 'package:flt_imo/Controller/InventoryController/inventoryListController.dart';
// import 'package:flt_imo/Controller/LocationController/locationListController.dart';
// import 'package:flt_imo/Models/inventoryModel.dart';
// import 'package:flt_imo/Models/locationModel.dart';
// import 'package:flt_imo/Utils/colors.dart';
// import 'package:flt_imo/Utils/strings.dart';
// import 'package:flt_imo/Widgets/10sizebox.dart';
// import 'package:flt_imo/Widgets/20sizebox.dart';
// import 'package:flt_imo/Widgets/noDataWidget.dart';
// import 'package:flt_imo/Widgets/pickers.dart';
// import 'package:flt_imo/Widgets/progressIndicator.dart';
// import 'package:flt_imo/Widgets/searchBar.dart';
// import 'package:flt_imo/Widgets/text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

// class LocationView extends StatelessWidget {
//   final LocationController locationController = Get.put(LocationController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0),
//               child: RefreshIndicator(
//                 onRefresh: locationController.getLocationRefresh,
//                 child: setListView(context),
//               ),
//             ),
//             CommanSearchBar(
//               onChanged: (text) {
//                 text = text.toLowerCase();
//                 locationController.locationListForDisplay = locationController.locationList.where((item) {
//                   var itemName = item.name.toLowerCase();
//                   return itemName.contains(text);
//                 }).toList();
//                 Get.forceAppUpdate();
//               },
//             ),
//           ],
//         ),
//       ),
//     ).wFull(context);
//   }

//   setListView(context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         bottom: 10,
//       ),
//       child: GetX<LocationController>(
//         init: Get.find<LocationController>(),
//         initState: (_) {
//           locationController.getLocationList();
//         },
//         builder: (c) {
//           return c.isLoading.value
//               ? progressIndicator()
//               : c.locationListForDisplay.isEmpty
//                   ? noDataWidget(txtLocation)
//                   : ListView.builder(
//                       shrinkWrap: true,
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: c.locationListForDisplay.length,
//                       itemBuilder: (context, index) {
//                         var loc = c.locationListForDisplay[index];
//                         return setBoxesView(context, loc);
//                       },
//                     );
//         },
//       ),
//     ).wFull(context);
//   }

//   setBoxesView(context, Location loc) {
//     return Stack(
//       children: [
//         ExpansionTile(
//           maintainState: true,
//           backgroundColor: white,
//           leading: Icon(
//             Icons.location_on,
//             color: primaryColor,
//             size: 35,
//           ),
//           childrenPadding: EdgeInsets.all(5),
//           subtitle: Text(
//             "${loc.address}",
//             style: TextStyle(
//               color: Colors.grey[800],
//             ),
//           ),
//           initiallyExpanded: false,
//           onExpansionChanged: (c) {
//             if (c == true) {
//               Get.find<InventoryListController>(tag: loc.id.toString()).getInventoryList(loc.id);
//             }
//           },
//           title: Text(
//             "${loc.name}",
//             style: TextStyle(
//               color: Colors.grey[800],
//             ),
//           ),
//           children: [
//             GetX<InventoryListController>(
//               init: Get.put(InventoryListController(), tag: loc.id.toString()),
//               initState: (_) {},
//               builder: (c) {
//                 return c.isLoading.value
//                     ? progressIndicator()
//                     : c.inventoryList.length == 0
//                         ? noDataWidget(txtInventory)
//                         : ListView.builder(
//                             itemCount: c.inventoryList.length,
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return "Title ".text.make();
//                             },
//                           );
//               },
//             )
//           ],
//         ),
//       ],
//     );
//   }

//   countBox(loc, context) {
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
//         decoration: BoxDecoration(color: Colors.green[400], borderRadius: BorderRadius.circular(5)),
//         child: title_text_white16bold(title: '40 Boxes in ${loc.inventoriesCount} Inventories', context: context),
//       ),
//     );
//   }

//   setInventoryView(context, Inventory inventory) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 0.0, bottom: 10, left: 0),
//             child: InkWell(
//               onTap: () {
//                 // Get.to(BoxesListScreen(inventory));
//               },
//               onLongPress: () {},
//               child: Container(
//                 transform: Matrix4.translationValues(0, 0, 0),
//                 child: Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   elevation: 5,
//                   color: white,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 transform: Matrix4.translationValues(20, 0, 0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     bigTitle_textNormalGrey(title: '${inventory.name}', context: context),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     TenSizeBox(),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         title_text16Bold(title: '${inventory.boxesCount} Boxes', context: context),
//                                         FifteenSizeBoxWidth(),
//                                         FifteenSizeBoxWidth(),
//                                         // Spacer(),
//                                         title_text_grey16(title: 'Created on ${dateFormat.format(inventory.createdOn)}', context: context),
//                                       ],
//                                     ),
//                                     TenSizeBox(),
//                                   ],
//                                 ),
//                               ),
//                               Spacer()
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Container(
//           //   child: ImageView(Images.IMAGE_GALLERY, 100, 100),
//           // ),
//         ],
//       ),
//     );
//   }
// }
