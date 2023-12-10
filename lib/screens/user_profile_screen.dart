import 'package:flutter/material.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/user_friends_screen.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/widgets/future_builder_with_loader.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen(
      {Key? key, required this.showAppBar, required this.username})
      : super(key: key);

  final bool showAppBar;
  final String username;

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserDetailModel _userDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text(
                'Profile',
              ),
            )
          : null,
      body: FutureBuilderWithLoader(
        future: APIService.getUserDetails(widget.username),
        onComplete: (snapshot) {
          _userDetails = snapshot.data as UserDetailModel;

          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 0.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 75,
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _userDetails.username!,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          profileButton(
                            'Likes',
                            Icons.thumb_up,
                            _userDetails.likedSongs!.length.toString(),
                            context,
                            _userDetails,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          profileButton(
                            'Friends',
                            Icons.people_alt_outlined,
                            _userDetails.friends!.length.toString(),
                            context,
                            _userDetails,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

SizedBox profileButton(String text, IconData icon, String val,
    BuildContext context, UserDetailModel details) {
  return SizedBox(
    height: 60,
    width: 160,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          Routes.userFriendsScreen,
          arguments: {
            'username': details.username!,
            'friendsList': details.friends!,
          },
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 25,
              ),
              const SizedBox(width: 2),
              Text(
                val,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    ),
  );
}
