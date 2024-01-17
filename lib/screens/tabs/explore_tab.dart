// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/home_screen.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/widgets/lists/cards/artist_list_card.dart';
import 'package:musicee_app/widgets/lists/recommendations_list.dart';
import 'package:musicee_app/widgets/lists/recommendations_list_artists.dart';

import '../../utils/color_manager.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({
    Key? key,
    required this.parentRefreshHolder,
  }) : super(key: key);

  final RefreshHolder parentRefreshHolder;

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    widget.parentRefreshHolder.tab1Refresh = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.allTracksScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      "All Songs",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 2,
                color: Colors.black12,
              ),
              Expanded(
                child: ListView(
                  children: [
                    RecommendationsList(
                      listTitle: 'Recommendations based on your profile',
                      futureTrackIDs: APIService.recommendTracks(
                        AuthManager.getUsername(),
                      ),
                    ),
                    RecommendationsList(
                      listTitle: 'Recommendations based on your friends',
                      futureTrackIDs: APIService.recommendFriendsTracks(
                        AuthManager.getUsername(),
                      ),
                    ),
                    RecommendationsListArtists(
                      listTitle: 'Reccommended Artists',
                      futureArtistNames: APIService.recommendArtists(
                        'uguroztunc', //AuthManager.getUsername(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTrackScreen);
        },
        tooltip: 'Add song',
        foregroundColor: ColorManager.colorAppBarText,
        backgroundColor: ColorManager.colorPrimary,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: const Icon(
          Icons.add_rounded,
          size: 35,
        ),
      ),
    );
  }
}
