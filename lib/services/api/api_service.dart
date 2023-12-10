import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/services/api/api_endpoint_manager.dart';
import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/models/sign_up_model.dart';

class APIService {
  const APIService._();

  static Future<SignUpResponseModel> signup(
      SignUpRequestModel requestModel) async {
    String url = ApiEndpointManager.user(UserEndpoints.SIGNUP);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel.toJson()),
    );

    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        var returnval =
            SignUpResponseModel.fromJson(json.decode(response.body));
        return returnval;
      } else {
        throw Exception('An error occured, try again');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<SignInResponseModel> login(
      SignInRequestModel requestModel) async {
    String url = ApiEndpointManager.user(UserEndpoints.LOGIN);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestModel.toJson()),
    );

    try {
      if (response.statusCode == 200 || response.statusCode == 400) {
        var returnval =
            SignInResponseModel.fromJson(json.decode(response.body));
        return returnval;
      } else {
        throw Exception('An error occured, try again');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<UserDetailModel>> getUsersAll() async {
    String url = ApiEndpointManager.users(UsersEndpoints.ALL);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        var returnval =
            jsonList.map((json) => UserDetailModel.fromJson(json)).toList();
        return returnval;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<UserDetailModel> getUserDetails(String username) async {
    String url = ApiEndpointManager.users(
      UsersEndpoints.DETAILS,
      username: username,
    );

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var returnval = UserDetailModel.fromJson(json.decode(response.body));
        return returnval;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<TrackModel>> getAllTracks() async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.GET_TRACKS);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        List<TrackModel> returnval =
            jsonList.map((json) => TrackModel.fromJson(json)).toList();
        return returnval;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<String> addTrack(TrackModel requestModel) async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.ADD_TRACK);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        String returnval = json.decode(response.body)['track_id'];
        return returnval;
      } else {
        throw Exception('An error occured, try again');
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
