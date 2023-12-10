import 'package:flutter/material.dart';
import 'package:musicee_app/screens/user_profile_screen.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return UserProfileScreen(
      showAppBar: false,
      username: AuthManager.getUsername(),
    );
  }
}
