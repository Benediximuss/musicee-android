class TrackModel {
  String? trackId;
  String trackName;
  List<String> trackArtist;
  String trackAlbum;
  int trackReleaseYear;
  int? trackRating;
  List<String>? likeList;
  List<String>? unlikeList;

  TrackModel({
    this.trackId = 'id',
    required this.trackName,
    required this.trackArtist,
    required this.trackAlbum,
    required this.trackReleaseYear,
    this.trackRating,
    this.likeList,
    this.unlikeList,
  });

  // Factory method to create a Track object from a map
  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      trackId: json['track_id'],
      trackName: json['track_name'],
      trackArtist: List<String>.from(json['track_artist']),
      trackAlbum: json['track_album'],
      trackReleaseYear: json['track_release_year'],
      likeList: List<String>.from(json['like_list']),
      unlikeList: List<String>.from(json['unlike_list']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'track_name': trackName.trim(),
      'track_artist': trackArtist,
      'track_album': trackAlbum,
      'track_release_year': trackReleaseYear,
    };
    return map;
  }
}
