import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class ArtistTracksScreen extends StatefulWidget {
  const ArtistTracksScreen({Key? key, required this.artistName}) : super(key: key);

  final String artistName;

  @override
  _ArtistTracksScreenState createState() => _ArtistTracksScreenState();
}

class _ArtistTracksScreenState extends State<ArtistTracksScreen> {
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
            text: "Songs of ",
            style: const TextStyle(
              color: ColorManager.colorAppBarText,
              fontSize: 20,
            ),
            children: [
              TextSpan(
                text: widget.artistName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: FutureBuilderWithLoader(
        future: _getSongsOf(widget.artistName),
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

  Future<List<TrackModel>> _getSongsOf(String username) async {
    try {
      print("3131: 3131313131");
      List<TrackModel>? allTracks = await APIService.getAllTracks();
      allTracks.removeWhere((track) => track.trackAlbum != widget.artistName);
      return allTracks;
    } catch (error) {
      print("3131: 6969696969");
      return Future.error(error);
    }
  }
}
