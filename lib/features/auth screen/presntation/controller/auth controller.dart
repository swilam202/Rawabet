import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/teke image.dart';
import '../../../../core/utils/user data.dart';
import '../../../../core/widgets/snack bar.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> rewritePasswordController =
      TextEditingController().obs;

  Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;

  dynamic reference = FirebaseStorage.instance;
  File? file;
  String? name;

  RxBool secure = true.obs;

  RxBool isLogin = true.obs;
  RxString url =
      'https://firebasestorage.googleapis.com/v0/b/chat-app-168d2.appspot.com/o/Rawabet%2Fuser.png?alt=media&token=bf630756-cc16-409b-b41f-bb9a91bd33ee'
          .obs;

  newImage(ImageSource source, BuildContext context) async {
    String? data = await takeImage(source);
    if (data != null) {
      url.value = data;
    }

    Navigator.of(context).pop();
  }

  void loginFunction(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      UserData.setData('id', emailController.value.text);

      emailController.value.clear();
      passwordController.value.clear();
      Navigator.of(context).pushReplacementNamed('home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnack('Warning', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnack('Warning', 'Wrong password provided for that user.');
      }
    }
  }

  void signupFunction(BuildContext context, CollectionReference users) async {
    try {
      if (key.value.currentState!.validate()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text,
        );
        String? token = await FirebaseMessaging.instance.getToken();
        users.add({
          'name': nameController.value.text,
          'id': emailController.value.text,
          'contacts': [],
          'image': url.value,
          'token': token!,
        });
        UserData.setData('id', emailController.value.text);
        nameController.value.clear();
        emailController.value.clear();
        passwordController.value.clear();
        rewritePasswordController.value.clear();

        Navigator.of(context).pushReplacementNamed('home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnack('Warning', 'The account already exists for that email.');
      }
    } catch (e) {
      showSnack('Warning', e.toString());
    }
  }
}
