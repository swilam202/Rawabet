import 'package:chatapp/features/auth%20screen/presntation/views/auth%20page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          primaryColor: const Color.fromRGBO(27, 150, 241, 1.0),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromRGBO(18, 109, 171, 1.0),
          ),),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      routes: {
        'texting': (context) => Texting(),
        'home': (context) => HomePage(),
        'login': (context) => AuthPage(),
      },
    );
  }
}
