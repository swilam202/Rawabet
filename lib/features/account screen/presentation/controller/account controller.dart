import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/teke image.dart';
import '../../../../core/utils/user data.dart';
import '../../../../core/widgets/new item.dart';
import '../../../../core/widgets/qr code.dart';
import '../../../../core/widgets/snack bar.dart';
import '../../../../core/widgets/toast.dart';

class AccountController extends GetxController {
  CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

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

    Get.bottomSheet(
      AddNewItem(
        controller: controller,
        label: 'Name',
        hint: 'Enter your new name',
        onPressed: () async {
          if (controller.text.length > 20 || controller.text.length < 3) {
            return showSnack('Warning',
                'Name must be more than 2 characters and less than 20');
          } else {
            QuerySnapshot<Map<String, dynamic>> querySnapshot = await users
                .where('id', isEqualTo: UserData.getData('id'))
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
      ),
      backgroundColor: Colors.white,
    );
  }

  void renewImage(ImageSource source, BuildContext context) async {
    String? url = await takeImage(source);
    if (url == null) {
      showToast('Something went wrong please try again');
    } else {
      QuerySnapshot<Map<String, dynamic>> query = await users
          .where(
            'id',
            isEqualTo: UserData.getData('id'),
          )
          .get();
      query.docs.forEach((doc) async {
        await doc.reference.update({'image': url});
      });
      Navigator.of(context).pop();
    }
  }
}
