import 'package:chatapp/componenets/custom%20text%20field.dart';
import 'package:chatapp/componenets/qr%20code.dart';
import 'package:chatapp/componenets/snack%20bar.dart';
import 'package:chatapp/controllers/home%20page%20controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  Account({
    required this.isSelfAccount,
    required this.id,
    required this.name,
    required this.image,
    super.key,
  });

  String image;
  String name;
  String id;
  bool isSelfAccount;
  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onDoubleTap: () => newName(context),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => onPress(id),
                onDoubleTap: () => onDoubleTap(id),
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
        ),
      ),
    );
  }

  void onPress(String url) {
     Get.defaultDialog(
      title: 'QR',
      content: CustomQRCode(url),
    );
  }

  void onDoubleTap(String url) {
    Clipboard.setData(
      ClipboardData(text: url),
    );
    Fluttertoast.showToast(
      msg: "the user id has been copied!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromRGBO(100, 100, 103, 1.0),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void newName(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = homePageController.userName.value;
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
                      await homePageController.users
                          .where('id', isEqualTo: homePageController.id)
                          .get();
                  querySnapshot.docs.forEach((doc) async {
                    await doc.reference.update(
                      {
                        'name': controller.text,
                      },
                    );
                  },);
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
}
