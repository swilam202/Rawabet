import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/loading state.dart';
import '../../controller/auth controller.dart';
import 'bottom sheet content.dart';
import 'text field section.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Form(
            key: authController.key.value,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(kGif),
                  ),
                ),
                authController.isLogin.value == false
                    ? GestureDetector(
                        onTap: () async {
                          return await Get.bottomSheet(
                            ImageBottomSheet(
                              cameraFunction: () => authController.newImage(
                                  ImageSource.camera, context),
                              galleryFunction: () => authController.newImage(
                                  ImageSource.gallery, context),
                            ),
                            backgroundColor: Colors.white,
                          );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              imageUrl: authController.url.value,
                              placeholder: (context, url) =>
                                  const LoadingState(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                TextFieldSection(),
                GestureDetector(
                  onTap: () => authController.isLogin.value =
                      !authController.isLogin.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      authController.isLogin.value
                          ? 'Create new account'
                          : 'already have an account',
                      style: const TextStyle(
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.015,
                        horizontal: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                  onPressed: () => authController.isLogin.value
                      ? authController.loginFunction(context)
                      : authController.signupFunction(context, users),
                  child: Text(
                    authController.isLogin.value == false
                        ? 'Sign up'
                        : 'Log in',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
