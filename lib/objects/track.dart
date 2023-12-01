class Track {
  String trackName;
  List<String> trackArtist;
  String trackAlbum;
  int trackRating;
  int trackId;
  int trackReleaseYear;

  Track({
    required this.trackName,
    required this.trackArtist,
    required this.trackAlbum,
    required this.trackRating,
    required this.trackId,
    required this.trackReleaseYear,
  });

  // Factory method to create a Track object from a map
  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      trackName: json['track_name'],
      trackArtist: List<String>.from(json['track_artist']),
      trackAlbum: json['track_album'],
      trackRating: json['track_rating'],
      trackId: json['track_id'],
      trackReleaseYear: json['track_release_year'],
    );
  }
}
