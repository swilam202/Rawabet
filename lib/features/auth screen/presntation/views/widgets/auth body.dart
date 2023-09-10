import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/core/widgets/loading%20state.dart';
import 'package:chatapp/features/auth%20screen/presntation/controller/auth%20controller.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/widgets/text%20field%20section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../pages/terms of use.dart';

//import '../../authController/auth authController.dart';
import 'bottom sheet content.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  // final CollectionReference users;

  @override
  Widget build(BuildContext context) {
    // AuthController authController = Get.put(AuthController());
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
                              placeholder: (context, url) => LoadingState(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                TextFieldSection(),
                authController.isLogin.value == false
                    ? Row(
                        children: [
                          Checkbox(
                              value: authController.policiesCheck.value,
                              onChanged: (val) =>
                                  authController.policiesCheck.value = val!),
                          GestureDetector(
                            onTap: () => Get.to(TermsOfUse()),
                            child: const Text(
                              'Agree to terms of use',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
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
