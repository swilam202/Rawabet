import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/core/utils/user%20data.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/auth%20page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/chat screen/presentation/views/chat page.dart';
import 'features/home screen/presentation/views/home page.dart';
import 'features/splash screen/presentation/views/splash page.dart';
import 'firebase_options.dart';
import 'pages/home page.dart';
import 'pages/login page.dart';
import 'pages/messageing page.dart';
//import 'splash screen/presentation/views/splash page.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await UserData.initSharedPreferences();

/*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data.toString()}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification!.body.toString()}');
  }
  print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
});*/


  if(UserData.getData('id') != null){
    String? token = await FirebaseMessaging.instance.getToken();
    var querySnapshot = await FirebaseFirestore.instance.collection('users').where('id',isEqualTo: UserData.getData('id')).get();
           querySnapshot.docs.forEach((doc) async {
                await doc.reference.update(
                  {
                    'token': token,
                  },
                );
              },);
          print('--------------------------------------------token------------------------------');
          //print(res.toString());
          print(token.toString());
                    print('--------------------------------------------token------------------------------');

  }
/*

    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  
  print('****************************************************************************');
  print("Handling a background message: ${message.messageId}");
}
     void a =  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


*/

  runApp(Rawabet());
}



class Rawabet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    

    return GetMaterialApp(
      theme: ThemeData(
          primaryColor: kLightColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kDarkColor,
          ),),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: {
        'texting': (context) => ChatPage(),
        'home': (context) => HomePage(),
        'login': (context) => AuthPage(),
      },
    );
  }
}
