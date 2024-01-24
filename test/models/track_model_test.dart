import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/track_model.dart';

void main() {
  group('TrackModel', () {
    test(
      'GIVEN a valid JSON representation of TrackModel'
      'WHEN a json deserialization is performed'
      'THEN a TrackModel instance with correct values should be returned',
      () {
        // GIVEN
        final json = {
          'track_id': 'test_id',
          'track_name': 'test_track_name',
          'track_artist': ['artist1', 'artist2'],
          'track_album': 'test_album',
          'genre': 'test_genre',
          'track_release_year': 2022,
          'like_list': ['user1', 'user2'],
        };

        // WHEN
        final track = TrackModel.fromJson(json);

        // THEN
        expect(track.trackId, 'test_id');
        expect(track.trackName, 'test_track_name');
        expect(track.trackArtist, ['artist1', 'artist2']);
        expect(track.trackAlbum, 'test_album');
        expect(track.genre, 'test_genre');
        expect(track.trackReleaseYear, 2022);
        expect(track.trackLikeList, ['user1', 'user2']);
      },
    );

    test(
      'GIVEN a TrackModel instance'
      'WHEN a json serialization is performed'
      'THEN a JSON representation with correct keys and values should be returned',
      () {
        // GIVEN
        final track = TrackModel(
          trackName: 'test_track_name',
          trackArtist: ['artist1', 'artist2'],
          trackAlbum: 'test_album',
          genre: 'test_genre',
          trackReleaseYear: 2022,
        );

        // WHEN
        final json = track.toJson();

        // THEN
        expect(json['track_id'], isNull);
        expect(json['track_name'], 'test_track_name');
        expect(json['track_artist'], ['artist1', 'artist2']);
        expect(json['track_album'], 'test_album');
        expect(json['genre'], 'test_genre');
        expect(json['track_release_year'], 2022);
        expect(json['like_list'], isNull);
      },
    );
  });
}
