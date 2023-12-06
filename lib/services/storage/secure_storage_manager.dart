import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  const SecureStorageManager._();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<String?> getValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> setValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<void> deleteKey(String key) async {
    await _secureStorage.delete(key: key);
  }

  static Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

}
