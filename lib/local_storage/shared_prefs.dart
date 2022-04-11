import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static void saveString(
      {required String key, required List<String> value}) async {
    await SharedPreferences.getInstance()
        .then((pref) => pref.setStringList(key, value));
  }

  static Future<List<String>> getString(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key) ?? [];
  }
}
