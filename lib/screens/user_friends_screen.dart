import 'package:flutter/material.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/cards/friend_list_card.dart';

class UserFriendsScreen extends StatefulWidget {
  const UserFriendsScreen({
    Key? key,
    required this.username,
    required this.friendsList,
  }) : super(key: key);

  final String username;
  final List<String> friendsList;

  @override
  _UserFriendsScreenState createState() => _UserFriendsScreenState();
}

class _UserFriendsScreenState extends State<UserFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "Friends of ",
            style: const TextStyle(
                color: ColorManager.colorAppBarText, fontSize: 20),
            children: [
              TextSpan(
                text: widget.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (widget.friendsList.isNotEmpty) {
            return ListView.builder(
              itemCount: widget.friendsList.length,
              itemBuilder: (context, index) {
                return FriendListCard(username: widget.friendsList[index]);
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ElevatedIcon(
                    iconData: Icons.lyrics_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'No friends here!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
