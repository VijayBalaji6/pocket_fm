import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDBServices {
  static final LocalDBServices _instance = LocalDBServices._internal();
  factory LocalDBServices() => _instance;
  LocalDBServices._internal();

  final FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  Future<String?> getData(String key) async {
    try {
      String? value = await _flutterSecureStorage.read(key: key);
      return value;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, String>> getAllData() async {
    try {
      Map<String, String> allValues = await _flutterSecureStorage.readAll();
      return allValues;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteData(String key) async {
    try {
      await _flutterSecureStorage.delete(key: key);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteAllData() async {
    try {
      await _flutterSecureStorage.deleteAll();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> writeData(String key, String value) async {
    try {
      await _flutterSecureStorage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }
}
