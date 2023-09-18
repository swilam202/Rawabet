import 'package:chatapp/core/utils/constants.dart';
import 'package:chatapp/features/auth%20screen/presntation/views/auth%20page.dart';
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
