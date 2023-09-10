// import 'package:path/path.dart';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../componenets/qr code.dart';
// import '../componenets/snack bar.dart';
// import '../componenets/toast.dart';
// //import '../controllers/home page controller.dart';
// import '../core/widgets/custom text field.dart';
// import '../features/home screen/presentation/controller/home page controller.dart';
//
// class Account extends StatelessWidget {
//   Account({
//     required this.isSelfAccount,
//     required this.id,
//     required this.name,
//     required this.image,
//     super.key,
//   });
//
//   String image;
//   String name;
//   String id;
//   bool isSelfAccount;
//   HomePageController homePageController = Get.put(HomePageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           height: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//
//             children: [
//               const SizedBox(height: 50),
//               GestureDetector(
//                 onDoubleTap: () async {
//
//                   if (isSelfAccount) {
//                     return await Get.bottomSheet(
//                       Wrap(
//                         children: [
//                           ListTile(
//                             title: const Text('Camera'),
//                             leading: const Icon(Icons.camera),
//                             onTap: () => newImage(ImageSource.camera, context),
//                           ),
//                           ListTile(
//                             title: const Text('Gallery'),
//                             leading: const Icon(Icons.image),
//                             onTap: () => newImage(ImageSource.gallery, context),
//                           ),
//                         ],
//                       ),
//                       backgroundColor: Colors.white,
//                     );
//                   }
//                 },
//                 child: CircleAvatar(
//                   radius: 100,
//                   backgroundColor: Colors.transparent,
//                   backgroundImage: NetworkImage(image),
//                 ),
//               ),
//               const SizedBox(height: 50),
//               GestureDetector(
//                 onDoubleTap: isSelfAccount ? () => newName(context) : () {},
//                 child: Text(
//                   name,
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               GestureDetector(
//                 onTap: () => onPress(id),
//                 onLongPress: () => onLongPress(id),
//                 child: Text(
//                   id,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void onPress(String url) {
//     Get.defaultDialog(
//       title: 'QR',
//       content: CustomQRCode(url),
//     );
//   }
//
//   void onLongPress(String url) {
//     Clipboard.setData(
//       ClipboardData(text: url),
//     );
//     showToast("the user id has been copied!");
//   }
//
//   void newName(BuildContext context) {
//     TextEditingController controller = TextEditingController();
//     controller.text = homePageController.userName.value;
//     Get.bottomSheet(
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Wrap(
//           alignment: WrapAlignment.center,
//           children: [
//             CustomTextField(
//               labelText: 'Name',
//               hintText: 'Enter your new name',
//               controller: controller,
//               icon: const Icon(Icons.drive_file_rename_outline),
//             ),
//             FloatingActionButton(
//               onPressed: () async {
//                 if (controller.text.length > 20 || controller.text.length < 3) {
//                   return showSnack('Warning',
//                       'Name must be more than 2 characters and less than 20');
//                 } else {
//                   QuerySnapshot<Map<String, dynamic>> querySnapshot =
//                       await homePageController.users
//                           .where('id', isEqualTo: homePageController.id)
//                           .get();
//                   querySnapshot.docs.forEach(
//                     (doc) async {
//                       await doc.reference.update(
//                         {
//                           'name': controller.text,
//                         },
//                       );
//                     },
//                   );
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Icon(Icons.edit),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
//
//   void newImage(ImageSource source, BuildContext context) async {
//     File file;
//     ImagePicker imagePicker = ImagePicker();
//     var image = await imagePicker.pickImage(source: source);
//     if (image != null) {
//       file = File(image.path);
//       String name = basename(image.path);
//       var reference = FirebaseStorage.instance.ref('Rawabet/images/$name');
//       await reference.putFile(file);
//       String url = await reference.getDownloadURL();
//       QuerySnapshot<Map<String, dynamic>> query = await homePageController.users
//           .where('id', isEqualTo: homePageController.id)
//           .get();
//       query.docs.forEach((doc) async {
//         await doc.reference.update({'image': url});
//       });
//       Navigator.of(context).pop();
//     } else {
//       showToast('Something went wrong please try again');
//     }
//   }
// }
