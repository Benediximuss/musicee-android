// ignore_for_file: constant_identifier_names

final class ApiEndpointManager {
  const ApiEndpointManager._();

  static const _baseUrl = 'http://musicee.us-west-2.elasticbeanstalk.com';

  static String api(ApiEndpoints endpoint) {
    var path = '$_baseUrl/api';
    switch (endpoint) {
      case ApiEndpoints.HEALTH: return '$path/health';
    }
  }

  static String user(UserEndpoints endpoint) {
    var path = '$_baseUrl/user';
    switch (endpoint) {
      case UserEndpoints.SIGNUP: return '$path/signup';
      case UserEndpoints.LOGIN: return '$path/login';
      case UserEndpoints.STAT_GENRE: return '$path/get_like_genre';
      case UserEndpoints.STAT_ARTIST: return '$path/get_like_artist';
      case UserEndpoints.STAT_FRIENDS: return '$path/get_like_friends';
    }
  }

 static String users(UsersEndpoints endpoint, {String username = '', String username2 = ''}) {
    var path = '$_baseUrl/users';
    switch (endpoint) {
      case UsersEndpoints.ALL: return '$path/all';
      case UsersEndpoints.DETAILS: return '$path/get_user_details/$username';
      case UsersEndpoints.ADD_FRIEND: return '$path/add_friend/$username/$username2';
    }
  }

  static String tracks(TracksEndpoints endpoint, {String trackID = ''}) {
    var path = '$_baseUrl/tracks';
    switch (endpoint) {
      case TracksEndpoints.GET_TRACKS: return '$path/get_tracks';
      case TracksEndpoints.GET_TRACK_DETAILS: return '$path/get_track_details/$trackID';
      case TracksEndpoints.ADD_TRACK: return '$path/add_track';
      case TracksEndpoints.UPDATE_TRACK: return '$path/update_track/$trackID';
      case TracksEndpoints.DELETE_TRACK: return '$path/delete_track/$trackID';
      case TracksEndpoints.LIKE_TRACK: return '$path/like_track';
      case TracksEndpoints.RECOMMEND_TRACKS: return '$path/recommend_track';
      case TracksEndpoints.RECOMMEND_FRIENDS_TRACKS: return '$path/recommend_friend_track';
      case TracksEndpoints.RECOMMEND_ARTISTS: return '$path/recommend_artist_track';
      case TracksEndpoints.POST_COMMENT: return '$path/post_comment';
      case TracksEndpoints.ADD_PLAYLIST: return '$path/add_playlist';
      case TracksEndpoints.DELETE_PLAYLIST: return '$path/delete_playlist';
    }
  }

  static String artist(ArtistEndpoints endpoint) {
    var path = '$_baseUrl/artist';
    switch (endpoint) {
      case ArtistEndpoints.TRACKS: return '$path/tracks';
    }
  }

  static String album(AlbumEndpoints endpoint) {
    var path = '$_baseUrl/album';
    switch (endpoint) {
      case AlbumEndpoints.TRACKS: return '$path/tracks';
    }
  }

  static String top(TopEndpoints endpoint) {
    switch (endpoint) {
      case TopEndpoints.POPULAR: return '$_baseUrl/popular_genre';
    }
  }

}

enum ApiEndpoints {
  HEALTH,
}

enum UserEndpoints {
  SIGNUP,
  LOGIN,
  STAT_GENRE,
  STAT_ARTIST,
  STAT_FRIENDS,
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
  RECOMMEND_ARTISTS,
  POST_COMMENT,
  ADD_PLAYLIST,
  DELETE_PLAYLIST,
}

enum ArtistEndpoints {
  TRACKS,
}

enum AlbumEndpoints {
  TRACKS,
}

enum TopEndpoints {
  POPULAR,
}