// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:musicee_app/screens/home_screen.dart';
import 'package:musicee_app/screens/user_profile_screen.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({
    Key? key,
    required this.parentRefreshHolder,
  }) : super(key: key);

  final RefreshHolder parentRefreshHolder;

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    print("3131: ASSIGNED");

    widget.parentRefreshHolder.tab3Refresh = () {
      print("3131: CALL");
      setState(() {});
    };
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("3131: PROFILEEE");
    return UserProfileScreen(
      showAppBar: false,
      username: AuthManager.getUsername(),
    );
  }
}
