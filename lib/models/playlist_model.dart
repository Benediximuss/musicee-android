class PlaylistModel {
  String listName;
  String listCreator;
  List<String> trackIDs;

  PlaylistModel({
    required this.listName,
    required this.listCreator,
    required this.trackIDs,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      listName: json['playlist_name'],
      listCreator: json['creator'],
      trackIDs: List<String>.from(json['playlist_tracks']),
    );
  }
}
