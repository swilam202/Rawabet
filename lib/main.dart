import 'package:chatapp/pages/home%20page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/Account.dart';
import 'pages/login page.dart';
import 'pages/messageing page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(27, 150, 241, 1.0),
       appBarTheme: const AppBarTheme(
         backgroundColor: Color.fromRGBO(18, 109, 171, 1.0),

       )
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        'texting':(context)=>Texting(),
        'home':(context)=>HomePage(),
        'login':(context)=>LoginPage(),
        //'account':(context)=>Account(),
      },
    );
  }
}



