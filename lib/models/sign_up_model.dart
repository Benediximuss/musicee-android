class SignUpResponseModel {
  final String username;
  final String email;
  final String error;

  SignUpResponseModel({
    required this.username,
    required this.email,
    required this.error,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('detail')) {
      return SignUpResponseModel(
        username: '',
        email: '',
        error: json['detail'] as String,
      );
    } else {
      return SignUpResponseModel(
        username: json['username'] as String,
        email: json['email'] as String,
        error: '',
      );
    }
  }
}

class SignUpRequestModel {
  String username;
  String email;
  String password;

  SignUpRequestModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
