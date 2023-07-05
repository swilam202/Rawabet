import 'package:chatapp/controllers/home%20page%20controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Account extends StatelessWidget {
   Account({super.key});



  @override
  Widget build(BuildContext context) {

    HomePageController controller = Get.put(HomePageController());


    return Scaffold(
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
              Text(controller.userName.value,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
              const SizedBox(height: 30),
              GestureDetector(
                  onLongPress: (){
                    Clipboard.setData(
                      ClipboardData(text: controller.args!),

                    );
                    Fluttertoast.showToast(
                        msg: "This is Center Short Toast",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  },
                  child: Text(controller.args!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w400,),),),
            ],
          ),
        ),
      ),
    );
  }
}
