import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            TextField(
              controller: emailController,
              onChanged: (data) {
                email = data;
              },
            ),
            TextField(
              controller: passwordController,
              onChanged: (data) {
                pass = data;
              },
            ),
            TextButton(
              child: const Text('add'),
              onPressed: () async {
                var auth = FirebaseAuth.instance;
                UserCredential userCredential =
                    await auth.createUserWithEmailAndPassword(
                        email: email!, password: pass!);
                print(userCredential.user!.email);
              },
            ),
          ],
        )),
      ),
    );
  }
}
