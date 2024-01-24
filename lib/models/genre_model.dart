import 'package:musicee_app/models/track_model.dart';

class GenreModel {
  String genreName;
  List<TrackModel> topTracks;

  GenreModel({
    required this.genreName,
    required this.topTracks,
  });

  // factory GenreModel.fromJson(Map<String, dynamic> json) {
  //   // fill this part
  // }
}
