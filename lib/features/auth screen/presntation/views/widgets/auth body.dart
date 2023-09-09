import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/core/widgets/loading%20state.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/widgets/text%20field%20section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../pages/terms of use.dart';
import '../../controller/auth controller.dart';
import 'bottom sheet content.dart';

class AuthBody extends StatelessWidget {
   const AuthBody({
    super.key
  });

  // final CollectionReference users;


  @override
  Widget build(BuildContext context) {
    // AuthController controller = Get.put(AuthController());
    final AuthController controller = Get.put(AuthController());

    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Form(
            key: controller.key.value,
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
                controller.isLogin.value == false
                    ? GestureDetector(
                        onTap: () async {
                          return await Get.bottomSheet(
                            BottomSheetContent(),
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
                              imageUrl: controller.url.value,
                              placeholder: (context, url) => LoadingState(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                TextFieldSection(),
                controller.isLogin.value == false
                    ? Row(
                        children: [
                          Checkbox(
                              value: controller.policiesCheck.value,
                              onChanged: (val) =>
                                  controller.policiesCheck.value = val!),
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
                  onTap: () =>
                      controller.isLogin.value = !controller.isLogin.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.isLogin.value
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
                  onPressed: () => controller.isLogin.value
                      ? controller.loginFunction(context)
                      : controller.signupFunction(context, users),
                  child: Text(
                    controller.isLogin.value == false ? 'Sign up' : 'Log in',
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
