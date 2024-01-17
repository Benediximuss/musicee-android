import 'package:flutter/material.dart';
import 'package:musicee_app/utils/color_manager.dart';
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
      body: ListView.builder(
        itemCount: widget.friendsList.length,
        itemBuilder: (context, index) {
          return FriendListCard(username: widget.friendsList[index]);
        },
      ),
    );
  }
}
