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

  static String tracks(TracksEndpoints endpoint) {
    var path = '$baseUrl/tracks';
    switch (endpoint) {
      case TracksEndpoints.GET_TRACKS: return '$path/get_tracks';
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

enum TracksEndpoints {
  GET_TRACKS,
}