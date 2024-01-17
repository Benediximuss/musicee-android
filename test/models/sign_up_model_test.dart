import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/sign_up_model.dart';

void main() {
  group('SignUpRequestModel', () {
    test(
      'GIVEN a sign up request model with username, email and password'
      'WHEN a json serialization is performed '
      'THEN a json with username, email and password should returned',
      () {
        final request = SignUpRequestModel(
          username: 'test_user',
          email: 'test_email',
          password: 'test_password',
        );

        final json = request.toJson();
        final matcher = {
          'username': 'test_user',
          'email': 'test_email',
          'password': 'test_password',
        };

        expect(json, matcher);
      },
    );
  });
  group('SignUpResponseModel', () {
    test(
      'GIVEN a valid json with email'
      'WHEN a json deserialization is performed'
      'THEN a sign up response model with email should returned',
      () {
        final json = {
          'email': 'test_email',
        };

        final response = SignUpResponseModel.fromJson(json);

        expect(response.email, 'test_email');
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

        final response = SignUpResponseModel.fromJson(json);

        expect(response.email, '');
        expect(response.error, 'test_error_message');
      },
    );
  });
}
