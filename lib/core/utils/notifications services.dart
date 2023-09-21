import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationsServices {
  static const String url = 'https://fcm.googleapis.com/fcm/send';
  static const String serverKey =
      'AAAAKYJSVVU:APA91bFlK2UFZDBxeBR7D36xP50CiumK7SOUQ4_qv9vBRHIoubN1iobbXinthCOhVgm8RSREl4Q32elxBgE9PHceSeFvVabdKafoqghbbswuliWDd8w0ObDl7pWHQwCHRH33mWKnmAxA';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  static pushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "to": token,
        "notification": {"title": title, "body": body}
      }),
      headers: headers,
    );
  }

  static Future<String> getToken() async {
    String token = (await FirebaseMessaging.instance.getToken())!;
    return token;
  }
}
