import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsServices{
  static const String url = 'https://fcm.googleapis.com/fcm/send';
  static const String serverKey = 'AAAAKYJSVVU:APA91bFlK2UFZDBxeBR7D36xP50CiumK7SOUQ4_qv9vBRHIoubN1iobbXinthCOhVgm8RSREl4Q32elxBgE9PHceSeFvVabdKafoqghbbswuliWDd8w0ObDl7pWHQwCHRH33mWKnmAxA';
  static const Map<String,String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

  static pushNotification({required String token,required String title,required String body})async{
  //cJjSOFAMRRC49aNoxhljp4:APA91bG8vyY-TFN1PNWmwSQSFCWKHmcRGQo5h5gzyT248hL0Or5545h8vYTqz27dXVxLkHfN6DhthVr1NIoiVQk13dBUQdEaIb4nuXfa_IjE716KvvuEN23yhaPQXfufGDxc-t8KBQ3q  
    Future.delayed(Duration(seconds: 2),()async{
      await http.post(
      Uri.parse(url),
      body: jsonEncode({
    "to":"fvDREm2CTTSqPTGarUR0MB:APA91bEmkonSNB7dIfhCYkIgFqLZiEj_lk18gR6wda6mrMGZjj7WnuPKHP9ozoQjlLP2z76xMSlicJm1YZJs5fhOIn2SRh7ItiUMQxFkfwWiJCF58Ehb9gQUpC9XNOV9dkcTXjFnba--",
    "notification":{
        "title":title,
        "body":body
    }
}),
    headers: headers,

    ).then((value) => print('doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'));
    });
  }

  static Future<String> getToken()async{
    String token = (await FirebaseMessaging.instance.getToken())!;
    return token;
  }
}
