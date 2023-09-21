import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/user data.dart';
import '../../../../core/widgets/loading state.dart';
import '../../../auth screen/presntation/views/widgets/bottom sheet content.dart';
import '../controller/account controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({
    required this.isSelfAccount,
    required this.id,
    this.name,
    this.image,
    super.key,
  });

  final String? image;
  final String? name;
  final String id;
  final bool isSelfAccount;
  final AccountController accountController = Get.put(AccountController());
  final Future<QuerySnapshot> user = FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: UserData.getData('id'))
      .get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingState();
          } else {
            return SizedBox(
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
                      child: CachedNetworkImage(
                        imageUrl: isSelfAccount
                            ? snapshot.data!.docs[0]['image']
                            : image,
                        placeholder: (context, url) => const LoadingState(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onDoubleTap: isSelfAccount
                        ? () => accountController.newName(context)
                        : null,
                    child: Text(
                      isSelfAccount ? snapshot.data!.docs[0]['name'] : name,
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
            );
          }
        },
      ),
    );
  }
}
