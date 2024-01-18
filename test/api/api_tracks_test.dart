import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_endpoint_manager.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHTTPClient extends Mock implements http.Client {}

void main() {
  late MockHTTPClient mockHTTPClient;

  setUp(() {
    mockHTTPClient = MockHTTPClient();
    APIService.init(
      client: mockHTTPClient,
    );
  });

  group('Tracks Requests', () {
    group(
      'getAllTracks function',
      () {
        test(
          'GIVEN APIService class'
          'WHEN the getAllTracks function is called and the status code of response is 200'
          'THEN a list of TrackModels should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.get(
                Uri.parse(
                    ApiEndpointManager.tracks(TracksEndpoints.GET_TRACKS)),
              ),
            ).thenAnswer((invocation) async {
              return http.Response(
                '''
              [
                  {
                      "track_id": "test_track_id",
                      "track_name": "test_track_name",
                      "track_artist": [
                          "test_track_artist"
                      ],
                      "track_album": "test_track_album",
                      "genre": "test_track_genre",
                      "track_release_year": 2023,
                      "like_list": [
                          "test_track_liked_user"
                      ]
                  },
                  {
                      "track_id": "test_track_id",
                      "track_name": "test_track_name",
                      "track_artist": [
                          "test_track_artist"
                      ],
                      "track_album": "test_track_album",
                      "genre": "test_track_genre",
                      "track_release_year": 2023,
                      "like_list": [
                          "test_track_liked_user"
                      ]
                  }
              ]
              ''',
                200,
              );
            });

            // Act
            final response = await APIService.getAllTracks();

            // Assert
            expect(response, isA<List<TrackModel>>());
          },
        );

        test(
          'GIVEN APIService class'
          'WHEN the getAllTracks function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.get(
                Uri.parse(
                    ApiEndpointManager.tracks(TracksEndpoints.GET_TRACKS)),
              ),
            ).thenAnswer((invocation) async => http.Response('{}', 500));

            // Act & Assert
            expect(APIService.getAllTracks(), throwsException);
          },
        );
      },
    );
    group(
      'getTrackDetails function',
      () {
        test(
          'GIVEN APIService class and a valid track ID'
          'WHEN the getTrackDetails function is called and the status code of response is 200'
          'THEN a TrackModel corresponding to given track ID should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(Uri.parse(ApiEndpointManager.tracks(
                      TracksEndpoints.GET_TRACK_DETAILS))
                  .replace(
                queryParameters: {'track_id': 'test_track_id'},
              )),
            ).thenAnswer((invocation) async {
              return http.Response(
                '''
                {
                    "track_id": "test_track_id",
                    "track_name": "test_track_name",
                    "track_artist": [
                        "test_track_artist"
                    ],
                    "track_album": "test_track_album",
                    "genre": "test_track_genre",
                    "track_release_year": 2023,
                    "like_list": [
                        "test_track_liked_user"
                    ]
                }
              ''',
                200,
              );
            });

            // Act
            final response = await APIService.getTrackDetails('test_track_id');

            // Assert
            expect(response, isA<TrackModel>());
            expect(response.trackId, 'test_track_id');
          },
        );

        test(
          'GIVEN APIService class and a invalid track ID'
          'WHEN the getTrackDetails function is called and the status code of response is 404'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(Uri.parse(ApiEndpointManager.tracks(
                      TracksEndpoints.GET_TRACK_DETAILS))
                  .replace(
                queryParameters: {'track_id': 'test_track_id'},
              )),
            ).thenAnswer((invocation) async {
              return http.Response(
                '''
                {
                    "message: Track with ID test_track_id does not exist."
                }
              ''',
                404,
              );
            });

            // Act & Assert
            expect(
                APIService.getTrackDetails('test_track_id'), throwsException);
          },
        );
      },
    );

    group(
      'addTrack function',
      () {
        test(
          'GIVEN APIService class and a valid TrackModel for request'
          'WHEN the addTrack function is called and the status code of response is 200'
          'THEN a String for track ID assigned for the new track should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(
                Uri.parse(
                  ApiEndpointManager.tracks(TracksEndpoints.ADD_TRACK),
                ),
                headers: {'Content-Type': 'application/json'},
                body: any(named: 'body'),
              ),
            ).thenAnswer(
              (invocation) async {
                return http.Response(
                  '''
                  {
                    "message": "Track added successfully.",
                    "track_id": "test_new_track_id"
                  }
                  ''',
                  200,
                );
              },
            );

            // Act
            final response = await APIService.addTrack(
              TrackModel(
                trackName: 'test_track_name',
                trackArtist: ['test_track_artist1', 'test_track_artist2'],
                trackAlbum: 'test_track_album',
                genre: 'test_genre',
                trackReleaseYear: 2023,
              ),
            );

            // Assert
            expect(response, isA<String>());
            expect(response, 'test_new_track_id');
          },
        );

        test(
          'GIVEN APIService class and a valid TrackModel for request'
          'WHEN the addTrack function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(
                Uri.parse(
                  ApiEndpointManager.tracks(TracksEndpoints.ADD_TRACK),
                ),
                headers: {'Content-Type': 'application/json'},
                body: any(named: 'body'),
              ),
            ).thenAnswer(
              (invocation) async => http.Response('{}', 422),
            );

            // Act & Assert
            expect(
              APIService.addTrack(
                TrackModel(
                  trackName: 'test_track_name',
                  trackArtist: ['test_track_artist1', 'test_track_artist2'],
                  trackAlbum: 'test_track_album',
                  genre: 'test_genre',
                  trackReleaseYear: 2023,
                ),
              ),
              throwsException,
            );
          },
        );
      },
    );

    group(
      'updateTrack function',
      () {
        test(
          'GIVEN APIService class, a valid track ID and a valid TrackModel for request'
          'WHEN the updateTrack function is called and the status code of response is 200'
          'THEN a String for track ID of updated track should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.put(
                Uri.parse(
                  ApiEndpointManager.tracks(
                    TracksEndpoints.UPDATE_TRACK,
                    trackID: 'test_track_id',
                  ),
                ),
                headers: {'Content-Type': 'application/json'},
                body: any(named: 'body'),
              ),
            ).thenAnswer(
              (invocation) async {
                return http.Response(
                  '''
                  {
                    "message": "Track with ID test_track_id has been updated."
                  }
                  ''',
                  200,
                );
              },
            );

            // Act
            final response = await APIService.updateTrack(
              'test_track_id',
              TrackModel(
                trackName: 'test_track_name',
                trackArtist: ['test_track_artist1', 'test_track_artist2'],
                trackAlbum: 'test_track_album',
                genre: 'test_genre',
                trackReleaseYear: 2023,
              ),
            );

            // Assert
            expect(response, isA<String>());
            expect(response, 'test_track_id');
          },
        );

        test(
          'GIVEN APIService class, a valid track ID and a valid TrackModel for request'
          'WHEN the updateTrack function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.put(
                Uri.parse(
                  ApiEndpointManager.tracks(
                    TracksEndpoints.UPDATE_TRACK,
                    trackID: 'test_track_id',
                  ),
                ),
                headers: {'Content-Type': 'application/json'},
                body: any(named: 'body'),
              ),
            ).thenAnswer(
              (invocation) async => http.Response('{}', 500),
            );

            // Act & Assert
            expect(
              APIService.updateTrack(
                'test_track_id',
                TrackModel(
                  trackName: 'test_track_name',
                  trackArtist: ['test_track_artist1', 'test_track_artist2'],
                  trackAlbum: 'test_track_album',
                  genre: 'test_genre',
                  trackReleaseYear: 2023,
                ),
              ),
              throwsException,
            );
          },
        );
      },
    );

    group(
      'deleteTrack function',
      () {
        test(
          'GIVEN APIService class and a valid track ID'
          'WHEN the deleteTrack function is called and the status code of response is 200'
          'THEN neither anything should be returned nor an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.delete(
                Uri.parse(
                  ApiEndpointManager.tracks(
                    TracksEndpoints.DELETE_TRACK,
                    trackID: 'test_track_id',
                  ),
                ),
                headers: {'Content-Type': 'application/json'},
              ),
            ).thenAnswer(
              (invocation) async {
                return http.Response(
                  '''
                  {
                    "message": "Track with ID test_track_id has been deleted."
                  }
                  ''',
                  200,
                );
              },
            );

            // Assert
            expect(
              APIService.deleteTrack('test_track_id'),
              completion(equals(null)),
            );
          },
        );

        test(
          'GIVEN APIService class and a track ID'
          'WHEN the deleteTrack function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.delete(
                Uri.parse(
                  ApiEndpointManager.tracks(
                    TracksEndpoints.DELETE_TRACK,
                    trackID: 'test_track_id',
                  ),
                ),
                headers: {'Content-Type': 'application/json'},
              ),
            ).thenAnswer(
              (invocation) async => http.Response('{}', 500),
            );

            // Assert
            expect(
              APIService.deleteTrack('test_track_id'),
              throwsException,
            );
          },
        );
      },
    );

    group(
      'likeTrack function',
      () {
        test(
          'GIVEN APIService class, a valid username and a valid track ID'
          'WHEN the likeTrack function is called and the status code of response is 200'
          'THEN neither anything should be returned nor an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(
                Uri.parse(
                  ApiEndpointManager.tracks(TracksEndpoints.LIKE_TRACK),
                ).replace(
                  queryParameters: {
                    'username': 'test_username',
                    'track_id': 'test_track_id',
                  },
                ),
              ),
            ).thenAnswer(
              (invocation) async {
                return http.Response(
                  '''
                  {
                    "message": "Track test_track_id liked."
                  }
                  ''',
                  200,
                );
              },
            );

            // Assert
            expect(
              APIService.likeTrack('test_username', 'test_track_id'),
              completion(equals(null)),
            );
          },
        );

        test(
          'GIVEN APIService class, a valid username and a valid track ID'
          'WHEN the likeTrack function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(
                Uri.parse(
                  ApiEndpointManager.tracks(TracksEndpoints.LIKE_TRACK),
                ).replace(
                  queryParameters: {
                    'username': 'test_username',
                    'track_id': 'test_track_id',
                  },
                ),
              ),
            ).thenAnswer(
              (invocation) async => http.Response('{}', 500),
            );

            // Assert
            expect(
              APIService.likeTrack('test_username', 'test_track_id'),
              throwsException,
            );
          },
        );
      },
    );
    group(
      'recommendTracks function',
      () {
        test(
          'GIVEN APIService class and a valid username'
          'WHEN the recommendTracks function is called and the status code of response is 200'
          'THEN a list of Strings corresponding to track IDs should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(
                Uri.parse(
                  ApiEndpointManager.tracks(TracksEndpoints.RECOMMEND_TRACKS),
                ).replace(
                  queryParameters: {'username': 'test_username'},
                ),
              ),
            ).thenAnswer(
              (invocation) async {
                return http.Response(
                  '''
                    [
                        "test_track_id_1",
                        "test_track_id_2",
                        "test_track_id_3"
                    ]
                  ''',
                  200,
                );
              },
            );

            // Act
            final response = await APIService.recommendTracks('test_username');

            // Assert
            expect(response, isA<List<String>>());
            expect(response[0], 'test_track_id_1');
            expect(response[1], 'test_track_id_2');
            expect(response[2], 'test_track_id_3');
          },
        );

        test(
          'GIVEN APIService class and a valid username'
          'WHEN the recommendTracks function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.post(
                Uri.parse(
                  ApiEndpointManager.tracks(TracksEndpoints.RECOMMEND_TRACKS),
                ).replace(
                  queryParameters: {'username': 'test_username'},
                ),
              ),
            ).thenAnswer(
              (invocation) async => http.Response('{}', 500),
            );

            // Assert
            expect(
              APIService.recommendTracks('test_username'),
              throwsException,
            );
          },
        );
      },
    );
  });
}
