class SignInResponseModel {
  final String accessToken;
  final String refreshToken;
  final String error;

  SignInResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.error,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('detail')) {
      return SignInResponseModel(
        accessToken: '',
        refreshToken: '',
        error: json['detail'] as String,
      );
    } else {
      return SignInResponseModel(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
        error: '',
      );
    }
  }
}

class SignInRequestModel {
  String username;
  String password;

  SignInRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
