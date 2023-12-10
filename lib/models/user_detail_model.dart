class UserDetailModel {
  final String? username;
  final String email;
  final List<String>? friends;
  final List<String>? likedSongs;
  final List<String>? unlikedSongs;

  UserDetailModel({
    required this.username,
    required this.email,
    required this.friends,
    required this.likedSongs,
    required this.unlikedSongs,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      username: json['username'],
      email: json['email'],
      friends: List<String>.from(json['friends']),
      likedSongs: List<String>.from(json['liked_songs']),
      unlikedSongs: List<String>.from(json['unliked_songs']),
    );
  }
}
