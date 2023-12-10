import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';

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

class FriendListCard extends StatelessWidget {
  final String username;

  const FriendListCard({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.userProfileScreen,
          arguments: {
            'showAppBar': true,
            'username': username,
          },
        );
      },
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: const CircleAvatar(
            // Placeholder icon for profile picture
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          title: Text(username),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: ColorManager.colorAppBarText,
          ),

          // Add more details or actions related to the friend here
        ),
      ),
    );
  }
}
