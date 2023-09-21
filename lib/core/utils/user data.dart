import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late final SharedPreferences sharedPreferences;

  static Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setData(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  static String? getData(String key) {
    String? data = sharedPreferences.getString(key);
    return data;
  }

  static Future<void> deleteData(String key) async {
    await sharedPreferences.remove(key);
  }
}
