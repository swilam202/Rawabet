import 'dart:io';

import 'package:chatapp/constants.dart';
import 'package:chatapp/controllers/login%20controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../componenets/custom text field.dart';
import '../componenets/snack bar.dart';
import 'home page.dart';
import 'messageing page.dart';
import 'terms of use.dart';

class LoginPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rewritePasswordController = TextEditingController();
  LoginController controller = Get.put(LoginController());
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  dynamic reference = FirebaseStorage.instance;
  File? file;
  String? name;


  @override
  Widget build(BuildContext context) {

    signupFunction() async {
      // if(name != null && file != null) {
      //
      // }
      try {
        if (key.currentState!.validate() &&
            controller.policiesCheck.value == true) {
          UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          users.add({
            'name':nameController.text,
            'id':emailController.text,
            'contacts': [],
            'image': url,

          });
          Navigator.of(context).pushReplacementNamed('home',arguments: emailController.text);
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

    loginFunction() async {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.of(context).pushReplacementNamed('home',arguments: emailController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnack('Warning', 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          showSnack('Warning', 'Wrong password provided for that user.');
        }
      }
    }


    void takeImage(ImageSource source ,BuildContext context) async{

      ImagePicker imagePicker = ImagePicker();
      var image = await imagePicker.pickImage(source: source);
      if(image != null){
        file = File(image.path);
         name = basename(image.path);
        reference = FirebaseStorage.instance.ref('images/$name');
        await reference.putFile(file);
        controller.url.value = await reference.getDownloadURL();
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: Obx(
            () => SafeArea(

          child: Form(
            key: key,
            child: ListView(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset('assets/chat.gif'),
                  ),
                ),

                // void newImage(ImageSource source ,BuildContext context) async{
                //   File file;
                //   ImagePicker imagePicker = ImagePicker();
                //   var image = await imagePicker.pickImage(source: source);
                //   if(image != null){
                //     file = File(image.path);
                //     String name = basename(image.path);
                //     var reference = FirebaseStorage.instance.ref('images/$name');
                //     await reference.putFile(file);
                //     String url = await reference.getDownloadURL();
                //     QuerySnapshot<Map<String, dynamic>> query = await homePageController.users.where('id',isEqualTo: homePageController.id).get();
                //     query.docs.forEach((doc)async {
                //       await doc.reference.update(
                //           {'image':url}
                //       );
                //     });
                //     Navigator.of(context).pop();
                //   }
                //   else{
                //     showToast('Something went wrong please try again');
                //   }
                controller.isLogin.value == false ?GestureDetector(
                  onTap: ()async{
                    return await Get.bottomSheet(
                      Wrap(
                        children: [
                          ListTile(
                            title: const Text('Camera'),
                            leading: const Icon(Icons.camera),
                            onTap: ()=> takeImage(ImageSource.camera,context),
                          ),
                          ListTile(
                            title: const Text('Gallery'),
                            leading: const Icon(Icons.image),
                            onTap: ()=> takeImage(ImageSource.gallery,context),

                          ),
                        ],
                      ),
                      backgroundColor: Colors.white,
                    );
                  },

                  child:CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(

                      child: Image(
                        image: NetworkImage(controller.url.value),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ):const SizedBox(),
                controller.isLogin.value == false ?CustomTextField(
                  labelText: 'Name',
                  valid: (data) {
                    if (data!.length < 3 || data.length > 20)
                      return 'Name must be more than 2 characters and less than 20';
                    else
                      return null;
                  },
                  hintText: 'enter name here',
                  icon: const Icon(Icons.person),
                  controller: nameController,
                ):const SizedBox(),
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'enter email here',
                  icon: const Icon(Icons.alternate_email),
                  controller: emailController,
                  valid: (data) {
                    if (!data!.contains('@'))
                      return 'invalid email';
                    else
                      return null;
                  },
                ),
                CustomTextField(
                  labelText: 'Password',
                  hintText: 'enter password here',
                  icon: IconButton(
                    onPressed: () {
                      controller.secure.value = !controller.secure.value;
                    },
                    icon: Icon(
                      controller.secure.value
                          ? Icons.visibility
                          : Icons.visibility_off_rounded,
                    ),
                  ),
                  controller: passwordController,
                  obscure: controller.secure.value,
                  valid: (data) {
                    if (data!.length <= 6)
                      return 'password is too short';
                    else
                      return null;
                  },
                ),
                controller.isLogin.value == false
                    ? CustomTextField(
                  labelText: 'Rewrite password',
                  hintText: 'rewrite password here',
                  icon: IconButton(
                    onPressed: () {
                      controller.secure.value = !controller.secure.value;
                    },
                    icon: Icon(
                      controller.secure.value
                          ? Icons.visibility
                          : Icons.visibility_off_rounded,
                    ),
                  ),
                  controller: rewritePasswordController,
                  obscure: controller.secure.value,
                  valid: (data) {
                    if (data != passwordController.text)
                      return 'password does not match';
                    else
                      return null;
                  },
                )
                    : const SizedBox(),
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
                    child: Text(controller.isLogin.value
                        ? 'Create new account'
                        : 'already have an account'),
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 100),
                      ),
                    ),
                    onPressed: controller.isLogin.value
                        ? loginFunction
                        : signupFunction,
                    child: Text(
                      controller.isLogin.value == false ? 'Sign up' : 'Log in',
                    ),
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