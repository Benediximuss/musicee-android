import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/storage/secure_storage_keys.dart';
import 'package:musicee_app/services/storage/secure_storage_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:collection/collection.dart';

class AuthManager {
  AuthManager._();

  static String? _accessToken;
  static String? _email;
  static String? _username;

  static Future<bool> init() async {
    _accessToken = await SecureStorageManager.getValue(SecureStorageKeys.accessTokenKey);

    if (_accessToken != null) {
      print("3131: Token found!");
      return await _initCredentials();
    } else {
      print("3131: Token not found!");
      return false;
    }
  }

  static Future<bool> _initCredentials() async {
    _email = _extractEmail(_accessToken!);
    print("3131: Email decoded: $_email");
    _username = await _findUsernameOf(_email!);

    if (_username == null) {
      print("3131: Username not found, loggin out!");
      logout();
      return false;
    } else {
      print("3131: Username found: $_username");
      return true;
    }
  }

  static void _setAccessToken(String token) {
    SecureStorageManager.setValue(SecureStorageKeys.accessTokenKey, token);
    _accessToken = token;
  }

  static void _deleteToken() {
    SecureStorageManager.deleteKey(SecureStorageKeys.accessTokenKey);
    _accessToken = null;
  }

  static String _extractEmail(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['sub'];
  }

  static Future<String?> _findUsernameOf(String email) async {
    final allUsers = await APIService.getUsersAll().catchError((error) {
      print("3131: $error");
    });
    UserDetailModel? target = allUsers.firstWhereOrNull((user) => user.email == email);

    return target?.username;
  }

  static String getUsername() {
    return _username!;
  }

  static Future<SignInResponseModel> login(SignInRequestModel requestModel) async {
    final response = await APIService.login(requestModel);
    if (response.error.isEmpty) {
      _setAccessToken(response.accessToken);
      await _initCredentials();
    }

    return response;
  }

  static void logout() {
    _deleteToken();
    _email = null;
    _username = null;
  }

}
