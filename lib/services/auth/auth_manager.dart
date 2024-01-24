import 'package:musicee_app/models/sign_in_model.dart';
// import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/storage/secure_storage_keys.dart';
import 'package:musicee_app/services/storage/secure_storage_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:collection/collection.dart';

class AuthManager {
  AuthManager._();

  static String? _accessToken;
  static String? _email;
  static String? _username;

  static Future<bool> init() async {
    _accessToken =
        await SecureStorageManager.getValue(SecureStorageKeys.accessTokenKey);
    _username =
        await SecureStorageManager.getValue(SecureStorageKeys.usernameKey);

    bool isLogged = false;

    if (_accessToken != null && _username != null) {
      try {
        final userModel = await APIService.getUserDetails(_username!);
        _email = _extractEmail(_accessToken!);

        if (userModel.email != _email) {
          print("3131: Emails not matching!");
          isLogged = false;
        } else {
          print("3131: Welcome back $_username ($_email)");
          isLogged = true;
        }
      } catch (error) {
        print("3131: $error");
        isLogged = false;
      }
    } else {
      print("3131: No credentials!");
      isLogged = false;
    }

    if (!isLogged) {
      logout();
    }

    return isLogged;
  }

  static void _setAccessToken(String token) {
    SecureStorageManager.setValue(SecureStorageKeys.accessTokenKey, token);
    _accessToken = token;
  }

  static void _deleteToken() {
    SecureStorageManager.deleteKey(SecureStorageKeys.accessTokenKey);
    _accessToken = null;
  }

  static void _setUsername(String username) {
    SecureStorageManager.setValue(SecureStorageKeys.usernameKey, username);
    _username = username;
  }

  static void _deleteUsername() {
    SecureStorageManager.deleteKey(SecureStorageKeys.usernameKey);
    _username = null;
  }

  static String _extractEmail(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['sub'];
  }

  static String getUsername() {
    return _username!;
  }

  static Future<SignInResponseModel> login(
      SignInRequestModel requestModel) async {
    final response = await APIService.login(requestModel);

    if (response.error.isEmpty) {
      _setAccessToken(response.accessToken);
      _setUsername(requestModel.username);
    }

    return response;
  }

  static void logout() {
    _deleteToken();
    _deleteUsername();
    _email = null;
  }
}
