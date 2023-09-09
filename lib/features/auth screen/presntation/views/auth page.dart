import 'package:chatapp/componenets/snack%20bar.dart';
import 'package:chatapp/features/auth%20screen/presntation/controller/auth%20controller.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/widgets/auth%20body.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/widgets/bottom%20sheet%20content.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/widgets/text%20field%20section.dart';
import 'package:chatapp/pages/terms%20of%20use.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../componenets/custom text field.dart';

// import '../componenets/custom text field.dart';
// import '../componenets/snack bar.dart';
// import '../controllers/login controller.dart';
// import 'terms of use.dart';

class AuthPage extends StatelessWidget {

  AuthController controller = Get.put(AuthController());

  CollectionReference users = FirebaseFirestore.instance.collection('users');


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      body: AuthBody(),
    );
  }
}
