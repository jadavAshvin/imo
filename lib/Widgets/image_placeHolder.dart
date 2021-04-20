// import 'package:flt_imo/Utils/colors.dart';
// import 'package:flt_imo/Utils/images.dart';
// import 'package:flutter/material.dart';

// floatingPlaceHolder() {
//   return Container(
//     width: 75,
//     height: 75,
//     decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(5),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 1,
//           blurRadius: 5,
//           offset: Offset(2, 4), // changes position of shadow
//         ),
//       ],
//     ),
//     transform: Matrix4.translationValues(-40, -15, 0),
//     child: Container(
//       height: 40,
//       width: 40,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Image.asset(
//           Images.PLACE_HOLDER,
//           fit: BoxFit.contain,
//         ),
//       ),
//     ),
//   );
// }

// floatingCarouselPlaceHolder(images) {
//   return Container(
//     width: 75,
//     height: 75,
//     decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(5),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 1,
//           blurRadius: 5,
//           offset: Offset(2, 4), // changes position of shadow
//         ),
//       ],
//     ),
//     transform: Matrix4.translationValues(-40, -15, 0),
//     child: Container(
//       // // height: 40,
//       // width: 40,
//       child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: CarouselSlider(
//             options: CarouselOptions(
//               autoPlay: true,
//             ),
//             items: List.generate(images.length, (index) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Container(
//                       // width: MediaQuery.of(context).size.width,
//                       margin: EdgeInsets.symmetric(horizontal: 5.0),
//                       // decoration: BoxDecoration(color: Colors.amber),
//                       child: FadeInImage.assetNetwork(
//                         placeholder: Images.PLACE_HOLDER,
//                         image: images[index],
//                         // .replaceAll('\\', '//'),
//                         fit: BoxFit.fitWidth,
//                         // width: 110.0,
//                         // height: 110.0,
//                       ));
//                 },
//               );
//             }),
//           )),
//     ),
//   );
// }
// // Widget carousol(imageList){
// //   return CarouselSlider(
// //               options: CarouselOptions(
// //                 height: 200.0,
// //                 autoPlay: true,
// //                 autoPlayInterval: Duration(seconds: 3),
// //                 autoPlayAnimationDuration: Duration(milliseconds: 800),
// //                 autoPlayCurve: Curves.fastOutSlowIn,
// //                 pauseAutoPlayOnTouch: true,
// //                 aspectRatio: 2.0,
// //                 onPageChanged: (index, reason) {

// //               ),
// //               items: imageList.map((image){
// //                 return Builder(
// //                   builder:(BuildContext context){
// //                     return Container(
// //                       height: MediaQuery.of(context).size.height*0.30,
// //                       width: MediaQuery.of(context).size.width,
// //                       child: Card(
// //                         color: Colors.blueAccent,
// //                         child: ,
// //                       ),
// //                     );
// //                   }
// //                 );
// //               }).toList(),
// //             ),
// // }
// // floatingPlaceHolder() {
// //   return Container(
// //     width: 75,
// //     height: 75,
// //     decoration: BoxDecoration(
// //       color: white,
// //       borderRadius: BorderRadius.circular(5),
// //       boxShadow: [
// //         BoxShadow(
// //           color: Colors.grey.withOpacity(0.5),
// //           spreadRadius: 1,
// //           blurRadius: 5,
// //           offset: Offset(2, 4), // changes position of shadow
// //         ),
// //       ],
// //     ),
// //     transform: Matrix4.translationValues(-40, -15, 0),
// //     child: Container(
// //       height: 40,
// //       width: 40,
// //       child: Padding(
// //         padding: const EdgeInsets.all(10.0),
// //         child: Image.asset(
// //           Images.PLACE_HOLDER,
// //           fit: BoxFit.contain,
// //         ),
// //       ),
// //     ),
// //   );
// // }
