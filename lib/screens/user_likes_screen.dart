import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';

class UserLikesScreen extends StatefulWidget {
  const UserLikesScreen({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _UserLikesScreenState createState() => _UserLikesScreenState();
}

class _UserLikesScreenState extends State<UserLikesScreen> {
  late List<TrackModel> _tracksList;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "Liked songs of ",
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
      body: FutureBuilderWithLoader(
        future: _getLikedsOf(widget.username),
        onComplete: (snapshot) {
          _tracksList = snapshot.data as List<TrackModel>;
          return TrackListView(
            tracksList: _tracksList,
            refreshListScreen: _refresh,
            direction: Axis.vertical,
          );
        },
      ),
    );
  }

  Future<List<TrackModel>> _getLikedsOf(String username) async {
    try {
      List<String>? likedTrackIDs =
          (await APIService.getUserDetails(username)).likedSongs;

      if (likedTrackIDs == null) {
        print("3131: ıds NULL!!!");
        throw Exception('3131: TrackIDs NULL');
      }

      List<TrackModel> likedTracks = [];

      try {
        for (String trackID in likedTrackIDs) {
          likedTracks.add(await APIService.getTrackDetails(
            trackID,
            getGenre: true,
          ));
        }
      } catch (error) {
        print("3131: FOR LOOP ERROR!");
      }

      return likedTracks;
    } catch (error) {
      return Future.error(error);
    }
  }
}
