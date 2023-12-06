import 'package:musicee_app/services/storage/secure_storage_keys.dart';
import 'package:musicee_app/services/storage/secure_storage_manager.dart';

class AuthManager {
  AuthManager._();

  static String? _accessToken;

  static Future<void> init() async {
    _accessToken = await SecureStorageManager.getValue(SecureStorageKeys.accessTokenKey);
  }

  static void setAccessToken(String token) {
    SecureStorageManager.setValue(SecureStorageKeys.accessTokenKey, token);
    _accessToken = token;
  }

  static void deleteToken() {
    SecureStorageManager.deleteKey(SecureStorageKeys.accessTokenKey);
    _accessToken = null;
  }

  static bool hasToken() {
    return _accessToken != null;
  }
}
