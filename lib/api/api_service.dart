import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicee_app/api/api_endpoint_manager.dart';
import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/models/sign_up_model.dart';

class APIService {

  static Future<SignUpResponseModel> signup(SignUpRequestModel requestModel) async {
    String url = ApiEndpointManager.user(UserEndpoints.SIGNUP);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel.toJson()),
    );
    
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        var returnval = SignUpResponseModel.fromJson(json.decode(response.body));
        return returnval;
      } else {
        throw Exception('An error occured, try again');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<SignInResponseModel> login(SignInRequestModel requestModel) async {
    String url = ApiEndpointManager.user(UserEndpoints.LOGIN);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel.toJson()),
    );
    
    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        var returnval = SignInResponseModel.fromJson(json.decode(response.body));
        return returnval;
      } else {
        throw Exception('An error occured, try again');
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
