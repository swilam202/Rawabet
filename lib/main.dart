import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/utils/constants.dart';
import 'core/utils/user data.dart';
import 'features/auth screen/presntation/views/auth page.dart';
import 'features/chat screen/presentation/views/chat page.dart';
import 'features/home screen/presentation/views/home page.dart';
import 'features/splash screen/presentation/views/splash page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await UserData.initSharedPreferences();

  runApp(const Rawabet());
}

class Rawabet extends StatelessWidget {
  const Rawabet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: kLightColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kDarkColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      routes: {
        'texting': (context) => ChatPage(),
        'home': (context) => const HomePage(),
        'login': (context) => AuthPage(),
      },
    );
  }
}
