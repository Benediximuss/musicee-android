import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/user_detail_model.dart';
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

  group('Users Requests', () {
    group(
      'getUsersAll function',
      () {
        test(
          'GIVEN APIService class'
          'WHEN the getUsersAll function is called and the status code of response is 200'
          'THEN a list of UserDetailModels should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.get(
                Uri.parse(ApiEndpointManager.users(UsersEndpoints.ALL)),
              ),
            ).thenAnswer((invocation) async {
              return http.Response(
                '''
              [
                {
                    "username": "test_username",
                    "email": "test_email",
                    "password": "test_password",
                    "friends": [
                      "test_friend1",
                      "test_friend2"
                    ],
                    "liked_songs": [
                      "test_liked_song_id_1"
                    ],
                    "liked_songs_date": [
                      {
                        "test_liked_song_id_1": "test_like_date"
                      }
                    ]
                },
                {
                    "username": "test_username2",
                    "email": "test_email2",
                    "password": "test_password2",
                    "friends": [
                      "test_friend1",
                      "test_friend2"
                    ],
                    "liked_songs": [
                      "test_liked_song_id_2"
                    ],
                    "liked_songs_date": [
                      {
                        "test_liked_song_id_2": "test_like_date"
                      }
                    ]
                }
              ]
              ''',
                200,
              );
            });

            // Act
            final response = await APIService.getUsersAll();

            // Assert
            expect(response, isA<List<UserDetailModel>>());
          },
        );

        test(
          'GIVEN APIService class'
          'WHEN the getUsersAll function is called and the status code of response is not 200'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.get(
                Uri.parse(ApiEndpointManager.users(UsersEndpoints.ALL)),
              ),
            ).thenAnswer((invocation) async => http.Response('{}', 500));

            // Act & Assert
            expect(APIService.getUsersAll(), throwsException);
          },
        );
      },
    );

    group(
      'getUserDetails function',
      () {
        test(
          'GIVEN APIService class and a valid username'
          'WHEN the getUserDetails function is called and the status code of response is 200'
          'THEN a UserDetailModel corresponding to given username should be returned',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.get(
                Uri.parse(
                  ApiEndpointManager.users(
                    UsersEndpoints.DETAILS,
                    username: 'test_username',
                  ),
                ),
              ),
            ).thenAnswer((invocation) async {
              return http.Response(
                '''
                {
                  "username": "test_username",
                  "email": "test_email",
                  "password": "test_password",
                  "friends": [
                    "test_friend1",
                    "test_friend2"
                  ],
                  "liked_songs": [
                    "test_liked_song_id_1"
                  ],
                  "liked_songs_date": [
                    {
                      "test_liked_song_id_1": "test_like_date"
                    }
                  ]
                }
                ''',
                200,
              );
            });

            // Act
            final response = await APIService.getUserDetails('test_username');

            // Assert
            expect(response, isA<UserDetailModel>());
            expect(response.username, 'test_username');
          },
        );

        test(
          'GIVEN APIService class and a invalid username'
          'WHEN the getUserDetails function is called and the status code of response is 404'
          'THEN an exception should be thrown',
          () async {
            // Arrange
            when(
              () => mockHTTPClient.get(
                Uri.parse(
                  ApiEndpointManager.users(
                    UsersEndpoints.DETAILS,
                    username: 'test_username',
                  ),
                ),
              ),
            ).thenAnswer(
              (invocation) async {
                return http.Response(
                  '''
                  {
                      "detail: User with username test_username not found."
                  }
                  ''',
                  404,
                );
              },
            );

            // Act & Assert
            expect(
              APIService.getUserDetails('test_username'),
              throwsException,
            );
          },
        );
      },
    );
  });
}
