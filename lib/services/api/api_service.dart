// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/services/api/api_endpoint_manager.dart';
import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/models/sign_up_model.dart';
import 'package:collection/collection.dart';

class APIService {
  const APIService._();

  static late http.Client httpClient;

  static void init({http.Client? client}) {
    httpClient = client ?? http.Client();
  }

  static Future<SignUpResponseModel> signup(
      SignUpRequestModel requestModel) async {
    String url = ApiEndpointManager.user(UserEndpoints.SIGNUP);

    final response = await httpClient.post(
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
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<SignInResponseModel> login(
      SignInRequestModel requestModel) async {
    String url = ApiEndpointManager.user(UserEndpoints.LOGIN);

    final response = await httpClient.post(
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
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<UserDetailModel>> getUsersAll() async {
    String url = ApiEndpointManager.users(UsersEndpoints.ALL);

    try {
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        var returnval =
            jsonList.map((json) => UserDetailModel.fromJson(json)).toList();
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
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
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var returnval = UserDetailModel.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
        return returnval;
      } else if (response.statusCode == 404) {
        throw Exception('404');
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<TrackModel>> getAllTracks() async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.GET_TRACKS);

    try {
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        List<TrackModel> returnval =
            jsonList.map((json) => TrackModel.fromJson(json)).toList();
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<TrackModel> getTrackDetails(String trackID,
      {bool getGenre = false}) async {
    String url = ApiEndpointManager.tracks(
      TracksEndpoints.GET_TRACK_DETAILS,
      trackID: trackID,
    );

    try {
      final response = await httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var returnval =
            TrackModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

        if (getGenre) {
          returnval.genre ??= await _findGenreOf(returnval.trackId!);
        }

        return returnval;
      } else if (response.statusCode == 500) {
        print("3131: TRACK DETAILS RESPONDED 500, LOOKING ALL SONGS");
        List<TrackModel> tracks = await getAllTracks();
        for (var element in tracks) {
          if (element.trackId == trackID) {
            return element;
          }
        }
        throw Exception('500 INTERNAL SERVER ERROR NO ID');
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<String> addTrack(TrackModel requestModel) async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.ADD_TRACK);

    try {
      final response = await httpClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        String returnval = json.decode(response.body)['track_id'];
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<String> updateTrack(
      String trackID, TrackModel requestModel) async {
    String url = ApiEndpointManager.tracks(
      TracksEndpoints.UPDATE_TRACK,
      trackID: trackID,
    );

    try {
      final response = await httpClient.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestModel.toJson()),
      );

      if (response.statusCode == 200) {
        return trackID;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<dynamic> deleteTrack(String trackID) async {
    String url = ApiEndpointManager.tracks(
      TracksEndpoints.DELETE_TRACK,
      trackID: trackID,
    );

    try {
      final response = await httpClient.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<dynamic> likeTrack(String username, String trackID) async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.LIKE_TRACK);

    try {
      final response = await httpClient.post(Uri.parse(url).replace(
        queryParameters: {
          'username': username,
          'track_id': trackID,
        },
      ));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<String>> recommendTracks(String username) async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.RECOMMEND_TRACKS);

    try {
      final response = await httpClient.post(
          Uri.parse(url).replace(queryParameters: {'username': username}));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        List<String> returnval =
            jsonList.map((json) => json.toString()).toList();
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<String>> recommendFriendsTracks(String username) async {
    String url =
        ApiEndpointManager.tracks(TracksEndpoints.RECOMMEND_FRIENDS_TRACKS);

    try {
      final response = await httpClient.post(
          Uri.parse(url).replace(queryParameters: {'username': username}));

      dynamic responseBody = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        return responseBody.cast<String>();
      } else if (responseBody.containsKey('detail')) {
        return [];
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      print('3131: $error');
      return Future.error(error);
    }
  }

  static Future<List<String>> recommendArtists(String username) async {
    String url = ApiEndpointManager.tracks(TracksEndpoints.RECOMMEND_ARTISTS);

    try {
      final response = await httpClient.post(
          Uri.parse(url).replace(queryParameters: {'username': username}));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<String> returnval =
            json.decode(utf8.decode(response.bodyBytes)).cast<String>();
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<String?> _findGenreOf(String trackID) async {
    final allTracks = await APIService.getAllTracks().catchError((error) {
      print("3131: $error");
    });
    TrackModel? target =
        allTracks.firstWhereOrNull((track) => track.trackId == trackID);

    return target?.genre;
  }

  static Future<dynamic> addFriend(
      String username, String targetUsername) async {
    String url = ApiEndpointManager.users(
      UsersEndpoints.ADD_FRIEND,
      username: username,
      username2: targetUsername,
    );

    try {
      final response = await httpClient.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<TrackModel>> artistAllTracks(String artistName) async {
    String url = ApiEndpointManager.artist(ArtistEndpoints.TRACKS);

    try {
      final response = await httpClient.get(Uri.parse(url).replace(
        queryParameters: {'track_artist': artistName},
      ));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        List<TrackModel> returnval =
            jsonList.map((json) => TrackModel.fromJson(json)).toList();
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<List<TrackModel>> albumAllTracks(String albumName) async {
    String url = ApiEndpointManager.album(AlbumEndpoints.TRACKS);

    try {
      final response = await httpClient.get(Uri.parse(url).replace(
        queryParameters: {'track_album': albumName},
      ));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
        List<TrackModel> returnval =
            jsonList.map((json) => TrackModel.fromJson(json)).toList();
        return returnval;
      } else {
        throw Exception(
            'Failed to get data from server (Status code: ${response.statusCode})');
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
