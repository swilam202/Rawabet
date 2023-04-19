import 'package:chatapp/componenets/custom%20text%20field.dart';
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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/chat.gif'),
              ),
            ),
            customTextField(
              labelText: 'Email',
              hintText: 'enter email here',
              icon: const Icon(Icons.alternate_email),
              controller: emailController,
              obscure: false,
            ),
            customTextField(
              labelText: 'Password',
              hintText: 'enter password here',
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    secure = !secure;
                  });
                },
                icon: Icon(
                  secure ? Icons.visibility : Icons.visibility_off_rounded,
                ),
              ),
              controller: passwordController,
              obscure: secure,
            ),
            Row(
              children: [

              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
                child: const Text('Sign up'),
                onPressed: () async {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  print(userCredential.toString());
                },
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
