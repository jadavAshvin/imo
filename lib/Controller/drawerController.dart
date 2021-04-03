// import 'package:get/get.dart';

// class DrawerController extends GetxController {
//   var imageFile = File("").obs;
// //Camera Actions
//   cameraAction(BuildContext context) {
//     showAdaptiveActionSheet(
//       title: Text(
//         txtSelectOption,
//         style: TextStyle(fontSize: 25),
//       ),
//       actions: <BottomSheetAction>[
//         BottomSheetAction(
//           title: Text(txtCamera, style: TextStyle(color: Colors.blue)),
//           onPressed: () {
//             getImageFromCamera(context);
//           },
//         ),
//         BottomSheetAction(
//           title: Text(
//             txtGallery,
//             style: TextStyle(color: Colors.blue),
//           ),
//           onPressed: () {
//             getImageFromGallery(context);
//           },
//         )
//       ],
//       cancelAction: CancelAction(
//         title: Text(txtCancel),
//         onPressed: () {
//           Get.back();
//         },
//       ),
//       context: context,
//     );
//     // showCupertinoModalPopup(context: context, builder: (context) => action);
//   }

//   Future getImageFromCamera(BuildContext context) async {
//     Get.back();
//     // showCropView(image);
//   }

//   Future getImageFromGallery(BuildContext context) async {
//     var image = await ImagePicker().getImage(source: ImageSource.gallery);
//     Navigator.pop(context);
//     showCropView(image);
//   }

//   void showCropView(PickedFile image) async {
//     File croppedFile = await ImageCropper.cropImage(
//         sourcePath: image.path,
//         aspectRatioPresets: Platform.isAndroid
//             ? [
//                 CropAspectRatioPreset.ratio3x2,
//               ]
//             : [
//                 CropAspectRatioPreset.square,
//               ],
//         aspectRatio: CropAspectRatio(ratioY: 2, ratioX: 3),
//         androidUiSettings: AndroidUiSettings(toolbarTitle: 'Cropper', initAspectRatio: CropAspectRatioPreset.square, lockAspectRatio: false),
//         iosUiSettings: IOSUiSettings(
//           aspectRatioLockEnabled: true,
//         ));

//     if (croppedFile != null) {
//       imageFile.value = croppedFile;
//       update();
//       print("selected file is $croppedFile");
//     }
//   }
// }
