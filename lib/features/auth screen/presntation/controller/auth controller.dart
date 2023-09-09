import 'dart:io';

import 'package:chatapp/core/utils/user%20data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../componenets/snack bar.dart';
import 'package:path/path.dart';

class AuthController extends GetxController {

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> rewritePasswordController = TextEditingController().obs;

   Rx<GlobalKey<FormState>> key = GlobalKey<FormState>().obs;

  dynamic reference = FirebaseStorage.instance;
  File? file;
  String? name;

  RxBool secure = true.obs;
  RxBool policiesCheck = false.obs;
  RxBool isLogin = true.obs;
  RxString url =
      'https://firebasestorage.googleapis.com/v0/b/chat-app-168d2.appspot.com/o/Rawabet%2Fuser.png?alt=media&token=bf630756-cc16-409b-b41f-bb9a91bd33ee'

          .obs;







  void takeImage(ImageSource source, BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: source);
    if (image != null) {
      file = File(image.path);
      name = basename(image.path);
      reference = FirebaseStorage.instance.ref('Rawabet/images/$name');
      await reference.putFile(file);
      url.value = await reference.getDownloadURL();
      Navigator.of(context).pop();
    }
  }


  loginFunction(BuildContext context) async {
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.value.text,
        password: passwordController.value.text,
      );
      setup(id: emailController.value.text);
      Navigator.of(context)
          .pushReplacementNamed('home', arguments: emailController.value.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnack('Warning', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnack('Warning', 'Wrong password provided for that user.');
      }
    }
  }


  signupFunction(BuildContext context,CollectionReference users) async {
    try {
      if (key.value.currentState!.validate() &&
          policiesCheck.value == true) {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.value.text,
          password: passwordController.value.text,
        );
        users.add({
          'name': nameController.value.text,
          'id': emailController.value.text,
          'contacts': [emailController.value.text],
          'image': url.value,
        });
        setup(id: emailController.value.text);
        Navigator.of(context)
            .pushReplacementNamed('home', arguments: emailController.value.text);
      } else
        return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnack('Warning', 'The account already exists for that email.');
      }
    } catch (e) {
      showSnack('Warning', e.toString());
    }
  }



}
