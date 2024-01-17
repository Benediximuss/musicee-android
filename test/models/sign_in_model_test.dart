import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/sign_in_model.dart';

void main() {
  group('SignInRequestModel', () {
    test(
      'GIVEN a sign in request model with username and password'
      'WHEN a json serialization is performed '
      'THEN a json with username and password should returned',
      () {
        final request = SignInRequestModel(
          username: 'test_user',
          password: 'test_password',
        );

        final json = request.toJson();
        final matcher = {
          'username': 'test_user',
          'password': 'test_password',
        };

        expect(json, matcher);
      },
    );
  });
  group('SignInResponseModel', () {
    test(
      'GIVEN a valid json with access token and refresh token'
      'WHEN a json deserialization is performed'
      'THEN a sign in response model with access and refresh token should returned',
      () {
        final json = {
          'access_token': 'test_access_token',
          'refresh_token': 'test_refresh_token',
        };

        final response = SignInResponseModel.fromJson(json);

        expect(response.accessToken, 'test_access_token');
        expect(response.refreshToken, 'test_refresh_token');
        expect(response.error, '');
      },
    );

    test(
      'GIVEN a json with error message'
      'WHEN a json deserialization is performed'
      'THEN a sign in response model with error message should returned',
      () {
        final json = {
          'detail': 'test_error_message',
        };

        final response = SignInResponseModel.fromJson(json);

        expect(response.accessToken, '');
        expect(response.refreshToken, '');
        expect(response.error, 'test_error_message');
      },
    );
  });
}
