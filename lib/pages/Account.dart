import 'package:chatapp/componenets/qr%20code.dart';
import 'package:chatapp/controllers/home%20page%20controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
  Account({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());

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
                backgroundImage: NetworkImage(controller.userImage.value),
              ),
              const SizedBox(height: 50),
              Text(
                controller.userName.value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: ()=>onPress(controller.args!),
                onDoubleTap: ()=>onDoubleTap(controller.args!),
                child: Text(
                  controller.args!,
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
}

onPress(String url){
  return Get.defaultDialog(
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



