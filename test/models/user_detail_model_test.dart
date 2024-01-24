import 'package:flutter_test/flutter_test.dart';
import 'package:musicee_app/models/user_detail_model.dart';

void main() {
  group('UserDetailModel', () {
    test(
      'GIVEN a valid JSON representation of UserDetailModel'
      'WHEN a json deserialization is performed'
      'THEN a UserDetailModel instance with correct values should be returned',
      () {
        // GIVEN
        final json = {
          'username': 'test_username',
          'email': 'test@email.com',
          'friends': ['friend1', 'friend2'],
          'liked_songs': ['song1', 'song2'],
        };

        // WHEN
        final userDetail = UserDetailModel.fromJson(json);

        // THEN
        expect(userDetail.username, 'test_username');
        expect(userDetail.email, 'test@email.com');
        expect(userDetail.friends, ['friend1', 'friend2']);
        expect(userDetail.likedSongs, ['song1', 'song2']);
      },
    );
  });
}
