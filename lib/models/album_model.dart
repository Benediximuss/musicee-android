class AlbumModel {
  String albumID;
  String albumName;

  AlbumModel({
    required this.albumID,
    required this.albumName,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      albumID: json['album_id'],
      albumName: json['album_name'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'album_id': albumID,
      'album_name': albumName.trim(),
    };
    return map;
  }
}
