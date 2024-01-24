import 'package:musicee_app/models/comment_model.dart';

class TrackModel {
  String? trackId;
  String trackName;
  List<String> trackArtist;
  String trackAlbum;
  String? genre;
  int trackReleaseYear;
  List<String>? trackLikeList;
  final List<CommentModel>? comments;

  TrackModel({
    this.trackId = 'id',
    required this.trackName,
    required this.trackArtist,
    required this.trackAlbum,
    this.genre,
    required this.trackReleaseYear,
    this.trackLikeList,
    this.comments,
  });

  // Factory method to create a Track object from a map
  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      trackId: json['track_id'],
      trackName: json['track_name'],
      trackArtist: List<String>.from(json['track_artist']),
      trackAlbum: json['track_album'],
      genre: json['genre'],
      trackReleaseYear: json['track_release_year'],
      trackLikeList: List<String>.from(json['like_list']),
      comments: (json['comment'] as List<dynamic>?)
          ?.map(
            (commentJson) => CommentModel.fromJson(
              commentJson,
              json['track_name'],
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'track_name': trackName.trim(),
      'track_artist': trackArtist.map((artist) => artist.trim()).toList(),
      'track_album': trackAlbum.trim(),
      'genre': genre?.trim(),
      'track_release_year': trackReleaseYear,
    };
    return map;
  }
}
