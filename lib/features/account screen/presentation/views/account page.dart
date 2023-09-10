import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/componenets/snack%20bar.dart';
import 'package:chatapp/componenets/toast.dart';
import 'package:chatapp/features/account%20screen/presentation/controller/account%20controller.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/widgets/bottom%20sheet%20content.dart';
import 'package:chatapp/features/home%20screen/presentation/controller/home%20page%20controller.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../componenets/qr code.dart';
import '../../../../core/widgets/custom text field.dart';

// import '../componenets/qr code.dart';
// import '../componenets/snack bar.dart';
// import '../componenets/toast.dart';
// //import '../controllers/home page controller.dart';
// import '../core/widgets/custom text field.dart';
// import '../features/home screen/presentation/controller/home page controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    required this.isSelfAccount,
    required this.id,
    required this.name,
    required this.image,
    super.key,
  });

  String image;
  String name;
  String id;
  bool isSelfAccount;
  AccountController accountController = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onDoubleTap: () async {
                  if (isSelfAccount) {
                    return await Get.bottomSheet(
                      ImageBottomSheet(
                        cameraFunction: () => accountController.renewImage(
                            ImageSource.camera, context),
                        galleryFunction: () => accountController.renewImage(
                            ImageSource.gallery, context),
                      ),
                      backgroundColor: Colors.white,
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(
                    image,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onDoubleTap: isSelfAccount
                    ? () => accountController.newName(context)
                    : () {},
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => accountController.onPress(id),
                onLongPress: () => accountController.onLongPress(id),
                child: Text(
                  id,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
