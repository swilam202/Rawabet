import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsServices{
  static sendNotification()async{
    String url = 'https://fcm.googleapis.com/fcm/send';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
    "to":"cJjSOFAMRRC49aNoxhljp4:APA91bG8vyY-TFN1PNWmwSQSFCWKHmcRGQo5h5gzyT248hL0Or5545h8vYTqz27dXVxLkHfN6DhthVr1NIoiVQk13dBUQdEaIb4nuXfa_IjE716KvvuEN23yhaPQXfufGDxc-t8KBQ3q",
    "notification":{
        "title":"title",
        "body":"body"
    }
}),
headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAKYJSVVU:APA91bFlK2UFZDBxeBR7D36xP50CiumK7SOUQ4_qv9vBRHIoubN1iobbXinthCOhVgm8RSREl4Q32elxBgE9PHceSeFvVabdKafoqghbbswuliWDd8w0ObDl7pWHQwCHRH33mWKnmAxA',
    },

    ).then((value) => print('doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'));
  }
}