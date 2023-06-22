
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ImageTest extends StatefulWidget {
  const ImageTest({Key? key}) : super(key: key);

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ()async{
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+1-555-123-4567',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {},
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          },
          child: Text('press me'),
        ),
      )

    );
  }
}




