import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';

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
        ),
      ),
    );
  }
}
