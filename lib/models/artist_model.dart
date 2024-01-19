class ArtistModel {
  String artistID;
  String artistName;

  ArtistModel({
    required this.artistID,
    required this.artistName,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      artistID: json['artist_id'],
      artistName: json['artist_name'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'artist_id': artistID,
      'artist_name': artistName.trim(),
    };
    return map;
  }
}
