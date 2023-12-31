// ignore_for_file: constant_identifier_names

final class ApiEndpointManager {
  const ApiEndpointManager._();

  static const baseUrl = 'http://musicee.us-west-2.elasticbeanstalk.com';

  static String api(ApiEndpoints endpoint) {
    var path = '$baseUrl/api';
    switch (endpoint) {
      case ApiEndpoints.HEALTH: return '$path/health';
    }
  }

  static String user(UserEndpoints endpoint) {
    var path = '$baseUrl/user';
    switch (endpoint) {
      case UserEndpoints.SIGNUP: return '$path/signup';
      case UserEndpoints.LOGIN: return '$path/login';
    }
  }

 static String users(UsersEndpoints endpoint, {String username = '', String username2 = ''}) {
    var path = '$baseUrl/users';
    switch (endpoint) {
      case UsersEndpoints.ALL: return '$path/all';
      case UsersEndpoints.DETAILS: return '$path/get_user_details/$username';
      case UsersEndpoints.ADD_FRIEND: return '$path/add_friend/$username/$username2';
    }
  }

  static String tracks(TracksEndpoints endpoint, {String trackID = ''}) {
    var path = '$baseUrl/tracks';
    switch (endpoint) {
      case TracksEndpoints.GET_TRACKS: return '$path/get_tracks';
      case TracksEndpoints.GET_TRACK_DETAILS: return '$path/get_track_details';
      case TracksEndpoints.ADD_TRACK: return '$path/add_track';
      case TracksEndpoints.UPDATE_TRACK: return '$path/update_track/$trackID';
      case TracksEndpoints.DELETE_TRACK: return '$path/delete_track/$trackID';
      case TracksEndpoints.LIKE_TRACK: return '$path/like_track';
      case TracksEndpoints.RECOMMEND_TRACKS: return '$path/recommend_track';
      case TracksEndpoints.RECOMMEND_FRIENDS_TRACKS: return '$path/recommend_friend_track';
    }
  }
}

enum ApiEndpoints {
  HEALTH,
}

enum UserEndpoints {
  SIGNUP,
  LOGIN,
}

enum UsersEndpoints {
  ALL,
  DETAILS,
  ADD_FRIEND,
}

enum TracksEndpoints {
  GET_TRACKS,
  GET_TRACK_DETAILS,
  ADD_TRACK,
  UPDATE_TRACK,
  DELETE_TRACK,
  LIKE_TRACK,
  RECOMMEND_TRACKS,
  RECOMMEND_FRIENDS_TRACKS,
}