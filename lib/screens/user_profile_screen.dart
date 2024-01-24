import 'package:flutter/material.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/stats_screen.dart';
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

  late Map<String, double> _genreMap;
  late Map<String, double> _artistsMap;
  late Map<String, double> _friendsMap;

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

    if (username == AuthManager.getUsername()) {
      _genreMap = await APIService.statGenre(AuthManager.getUsername());
      _artistsMap = await APIService.statArtist(AuthManager.getUsername());
      _friendsMap = await APIService.statFriends(AuthManager.getUsername());
    }

    return returnval;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text(
                'User Profile',
              ),
            )
          : null,
      body: FutureBuilderWithLoader(
        future: _futureFunction(
          widget.username,
        ),
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
                          _showLikesLogic(context);
                        },
                        iconSize: 25,
                      ),
                      CustomIconButton(
                        buttonText: 'Playlists',
                        buttonIcon: Icons.playlist_play_rounded,
                        buttonValue: _userDetails.playlists!.length.toString(),
                        onPressed: () {
                          _showPlaylistsLogic(context);
                        },
                        width: 175,
                        iconSize: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                        buttonText: 'Friends',
                        buttonIcon: Icons.people_alt_rounded,
                        buttonValue: _userDetails.friends!.length.toString(),
                        onPressed: () {
                          _showFriendsLogic(context);
                        },
                        iconSize: 25,
                      ),
                      CustomIconButton(
                        buttonText: 'Comments',
                        buttonIcon: Icons.comment_rounded,
                        buttonValue: _userDetails.comments!.length.toString(),
                        onPressed: () {
                          _showCommentsLogic(context);
                        },
                        width: 175,
                        fontSize: 20,
                        iconSize: 25,
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
                  if (widget.username == AuthManager.getUsername())
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          buttonText: 'Statistics',
                          buttonIcon: Icons.stacked_bar_chart_rounded,
                          onPressed: () {
                            _showStatsLogic(context);
                          },
                          width: 175,
                          iconSize: 30,
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

  void _showLikesLogic(BuildContext context) {
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
  }

  void _showFriendsLogic(BuildContext context) {
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

  void _showPlaylistsLogic(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.playlistsScreen,
      arguments: {
        'username': _userDetails.username!,
        'isSelf': _userDetails.username! == AuthManager.getUsername(),
      },
    );
  }

  void _showCommentsLogic(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.userCommentsScreen,
      arguments: {
        'username': _userDetails.username!,
      },
    ).then(
      (_) {
        _refresh();
      },
    );
  }

  void _showStatsLogic(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatsScreen(
          genreMap: _genreMap,
          artistMap: _artistsMap,
          friendsMap: _friendsMap,
        ),
      ),
    );
  }
}
