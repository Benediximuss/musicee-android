import 'package:flutter/material.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/widgets/components/add_friend_button.dart';
import 'package:musicee_app/widgets/components/custom_icon_button.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

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

  // UI Logic
  bool _isButtonLoading = false;
  late bool _isFriend;

  void _refresh() {
    setState(() {});
  }

  Future<UserDetailModel> _futureFunction(String username) async {
    final returnval = APIService.getUserDetails(username);

    final myProfile =
        await APIService.getUserDetails(AuthManager.getUsername());

    _isFriend = myProfile.friends!.contains(username);

    return returnval;
  }

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
        future: _futureFunction(
            widget.username), //APIService.getUserDetails(widget.username),
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
                      CustomIconButton(
                        buttonText: 'Likes',
                        buttonIcon: Icons.thumb_up,
                        buttonValue: _userDetails.likedSongs!.length.toString(),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.userLikesScreen,
                            arguments: {
                              'username': _userDetails.username!,
                            },
                          ).then(
                            (_) {
                              _refresh();
                            },
                          );
                        },
                      ),
                      CustomIconButton(
                        buttonText: 'Friends',
                        buttonIcon: Icons.people_alt_outlined,
                        buttonValue: _userDetails.friends!.length.toString(),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.userFriendsScreen,
                            arguments: {
                              'username': _userDetails.username!,
                              'friendsList': _userDetails.friends!,
                            },
                          ).then(
                            (_) {
                              _refresh();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (widget.username != AuthManager.getUsername())
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AddFriendButton(
                          isLoading: _isButtonLoading,
                          isFriend: _isFriend,
                          onPressed: _addFriendLogic,
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

  void _addFriendLogic() async {
    setState(() {
      _isButtonLoading = true;
    });

    APIService.addFriend(AuthManager.getUsername(), _userDetails.username!)
        .then((value) {
      setState(() {
        _isButtonLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isButtonLoading = false;
      });
      print("3131: Error adding!!! $error");
    });
  }
}
