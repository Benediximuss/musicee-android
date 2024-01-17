// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/screens/home_screen.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/widgets/lists/cards/friend_list_card.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class PeopleTab extends StatefulWidget {
  const PeopleTab({
    Key? key,
    required this.parentRefreshHolder,
  }) : super(key: key);

  final RefreshHolder parentRefreshHolder;

  @override
  _PeopleTabState createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    widget.parentRefreshHolder.tab2Refresh = () {
      setState(() {});
    };
  }

  late List<UserDetailModel> _usersList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWithLoader(
      future: APIService.getUsersAll(),
      onComplete: (snapshot) {
        _usersList = snapshot.data;
        return ListView.builder(
          itemCount: _usersList.length,
          itemBuilder: (context, index) {
            return FriendListCard(username: _usersList[index].username!);
          },
        );
      },
    );
  }
}
