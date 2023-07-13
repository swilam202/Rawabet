import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool secure = true.obs;
  RxBool policiesCheck = false.obs;
  RxBool isLogin = true.obs;
  RxString url =
      'https://firebasestorage.googleapis.com/v0/b/chat-app-168d2.appspot.com/o/user%20(1).png?alt=media&token=a6f09959-1970-4412-94fc-646f64d30119'
          .obs;
}
