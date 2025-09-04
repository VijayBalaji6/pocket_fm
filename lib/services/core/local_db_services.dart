import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  static final LocalDBServices instance = LocalDBServices._internal();
  LocalDBServices._internal();

  factory LocalDBServices() => instance;

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getData(String key) {
    try {
      String? value = prefs.getString(key);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteData(String key) async {
    try {
      await prefs.remove(key);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteAllData() async {
    try {
      await prefs.clear();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> writeData({required String key, required String value}) async {
    try {
      await prefs.setString(key, value);
    } catch (e) {
      rethrow;
    }
  }
}
