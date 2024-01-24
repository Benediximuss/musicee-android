import 'package:musicee_app/models/comment_model.dart';
import 'package:musicee_app/models/playlist_model.dart';

class UserDetailModel {
  final String? username;
  final String email;
  final List<String>? friends;
  final List<String>? likedSongs;
  final List<PlaylistModel>? playlists;
  List<CommentModel>? comments;

  UserDetailModel({
    required this.username,
    required this.email,
    required this.friends,
    required this.likedSongs,
    required this.playlists,
    required this.comments,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      username: json['username'],
      email: json['email'],
      friends: List<String>.from(json['friends']),
      likedSongs: List<String>.from(json['liked_songs']),
      playlists: (json['playlist'] as List<dynamic>?)
          ?.map(
            (commentJson) => PlaylistModel.fromJson(commentJson),
          )
          .toList(),
      comments: (json['comment'] as List<dynamic>?)
          ?.map(
            (commentJson) => CommentModel.fromJson(
              commentJson,
              'NO NAME',
            ),
          )
          .toList(),
    );
  }
}
