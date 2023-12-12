class UserDetailModel {
  final String? username;
  final String email;
  final List<String>? friends;
  final List<String>? likedSongs;

  UserDetailModel({
    required this.username,
    required this.email,
    required this.friends,
    required this.likedSongs,
  });

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      username: json['username'],
      email: json['email'],
      friends: List<String>.from(json['friends']),
      likedSongs: List<String>.from(json['liked_songs']),
    );
  }
}
