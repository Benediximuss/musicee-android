import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/sign_in_model.dart';
import 'package:musicee_app/models/sign_up_model.dart';
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

  group('User Requests', () {
    group('signup function', () {
      test(
        'GIVEN a successful signup request with valid data'
        'WHEN the signup function is called and the status code of response is 200'
        'THEN a SignUpResponseModel should be returned with the correct username and email and empty error message',
        () async {
          // Arrange
          when(
            () => mockHTTPClient.post(
              Uri.parse(ApiEndpointManager.user(UserEndpoints.SIGNUP)),
              headers: {'Content-Type': 'application/json'},
              body: any(named: 'body'),
            ),
          ).thenAnswer((invocation) async {
            return http.Response(
              '''
              {
                "username": "test_username",
                "email": "test_email"
              }
              ''',
              200,
            );
          });

          // Act
          final response = await APIService.signup(
            SignUpRequestModel(
              username: 'test_username',
              email: 'test_email',
              password: 'test_password',
            ),
          );

          // Assert
          expect(response, isA<SignUpResponseModel>());
          expect(response.username, 'test_username');
          expect(response.email, 'test_email');
          expect(response.error, '');
        },
      );
      test(
        'GIVEN an unsuccessful signup request with valid data'
        'WHEN the signup function is called and the status code of response is 400'
        'THEN a SignUpResponseModel should be returned with an error message',
        () async {
          // Arrange
          when(
            () => mockHTTPClient.post(
              Uri.parse(ApiEndpointManager.user(UserEndpoints.SIGNUP)),
              headers: {'Content-Type': 'application/json'},
              body: any(named: 'body'),
            ),
          ).thenAnswer((invocation) async {
            return http.Response(
              '''
              {
                "detail": "Email or username already exists"
              }
              ''',
              400,
            );
          });

          // Act
          final response = await APIService.signup(
            SignUpRequestModel(
              username: 'test_username',
              email: 'test_email',
              password: 'test_password',
            ),
          );

          // Assert
          expect(response, isA<SignUpResponseModel>());
          expect(response.username, '');
          expect(response.email, '');
          expect(response.error, 'Email or username already exists');
        },
      );
      test(
        'GIVEN a signup request with valid data'
        'WHEN the signup function is called and the status code of response is not 200 or 400'
        'THEN an exception should be thrown',
        () async {
          // Arrange
          when(
            () => mockHTTPClient.post(
              Uri.parse(ApiEndpointManager.user(UserEndpoints.SIGNUP)),
              headers: {'Content-Type': 'application/json'},
              body: any(named: 'body'),
            ),
          ).thenAnswer((invocation) async => http.Response('{}', 500));

          // Act
          expect(
            APIService.signup(
              SignUpRequestModel(
                username: 'test_username',
                email: 'test_email',
                password: 'test_password',
              ),
            ),
            throwsException,
          );
        },
      );
    });

    group('login function', () {
      test(
        'GIVEN a successful signin request with valid data'
        'WHEN the signin function is called and the status code of response is 200'
        'THEN a SignInResponseModel should be returned with access token and refresh token',
        () async {
          // Arrange
          when(
            () => mockHTTPClient.post(
              Uri.parse(ApiEndpointManager.user(UserEndpoints.LOGIN)),
              headers: {'Content-Type': 'application/json'},
              body: any(named: 'body'),
            ),
          ).thenAnswer((invocation) async {
            return http.Response(
              '''
              {
                  "access_token": "test_access_token",
                  "refresh_token": "test_refresh_token"
              }
              ''',
              200,
            );
          });

          // Act
          final response = await APIService.login(
            SignInRequestModel(
              username: 'test_username',
              password: 'test_password',
            ),
          );

          // Assert
          expect(response, isA<SignInResponseModel>());
          expect(response.accessToken, 'test_access_token');
          expect(response.refreshToken, 'test_refresh_token');
          expect(response.error, '');
        },
      );
      test(
        'GIVEN an unsuccessful signin request with valid data'
        'WHEN the signin function is called and the status code of response is 400'
        'THEN a SignInResponseModel should be returned with an error message',
        () async {
          // Arrange
          when(
            () => mockHTTPClient.post(
              Uri.parse(ApiEndpointManager.user(UserEndpoints.LOGIN)),
              headers: {'Content-Type': 'application/json'},
              body: any(named: 'body'),
            ),
          ).thenAnswer((invocation) async {
            return http.Response(
              '''
              {
                "detail": "Incorrect email or password"
              }
              ''',
              400,
            );
          });

          // Act
          final response = await APIService.login(
            SignInRequestModel(
              username: 'test_username',
              password: 'test_password',
            ),
          );

          // Assert
          expect(response, isA<SignInResponseModel>());
          expect(response.accessToken, '');
          expect(response.refreshToken, '');
          expect(response.error, 'Incorrect email or password');
        },
      );
      test(
        'GIVEN a signin request with valid data'
        'WHEN the signin function is called and the status code of response is not 200 or 400'
        'THEN an exception should be thrown',
        () async {
          // Arrange
          when(
            () => mockHTTPClient.post(
              Uri.parse(ApiEndpointManager.user(UserEndpoints.LOGIN)),
              headers: {'Content-Type': 'application/json'},
              body: any(named: 'body'),
            ),
          ).thenAnswer((invocation) async => http.Response('{}', 500));

          // Act & Assert
          expect(
            APIService.login(
              SignInRequestModel(
                username: 'test_username',
                password: 'test_password',
              ),
            ),
            throwsException,
          );
        },
      );
    });
  });
}
