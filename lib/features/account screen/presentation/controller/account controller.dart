import 'dart:io';
import 'package:chatapp/core/utils/teke%20image.dart';
import 'package:path/path.dart';
import 'package:chatapp/core/utils/user%20data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../componenets/qr code.dart';
import '../../../../componenets/snack bar.dart';
import '../../../../componenets/toast.dart';
import '../../../../core/widgets/custom text field.dart';


class AccountController extends GetxController{
  CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');


  void onPress(String url) {
    Get.defaultDialog(
      title: 'QR',
      content: CustomQRCode(url),
    );
  }

  void onLongPress(String url) {
    Clipboard.setData(
      ClipboardData(text: url),
    );
    showToast("the user id has been copied!");
  }

  void newName(BuildContext context) {
    TextEditingController controller = TextEditingController();
    //controller.text = homePageController.userName.value;
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            CustomTextField(
              labelText: 'Name',
              hintText: 'Enter your new name',
              controller: controller,
              icon: const Icon(Icons.drive_file_rename_outline),
            ),
            FloatingActionButton(
              onPressed: () async {
                if (controller.text.length > 20 || controller.text.length < 3) {
                  return showSnack('Warning',
                      'Name must be more than 2 characters and less than 20');
                } else {
                  QuerySnapshot<Map<String, dynamic>> querySnapshot =
                  await users
                      .where('id', isEqualTo: getIt.get<String>())
                      .get();
                  querySnapshot.docs.forEach(
                        (doc) async {
                      await doc.reference.update(
                        {
                          'name': controller.text,
                        },
                      );
                    },
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void renewImage(ImageSource source, BuildContext context) async {

      String? url = await takeImage(source);
      if(url == null){
        showToast('Something went wrong please try again');
      }
      else {
        QuerySnapshot<Map<String, dynamic>> query = await users
            .where('id', isEqualTo: getIt.get<String>())
            .get();
        query.docs.forEach((doc) async {
          await doc.reference.update({'image': url});
        });
        Navigator.of(context).pop();
      }

    }
  }
