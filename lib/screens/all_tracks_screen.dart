import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';

class AllTracksScreen extends StatefulWidget {
  const AllTracksScreen({super.key});

  @override
  _AllTracksScreenState createState() => _AllTracksScreenState();
}

class _AllTracksScreenState extends State<AllTracksScreen> {
  late List<TrackModel> _tracksList;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
        actions: [
          TextButton(
            onPressed: () {
              _refresh();
            },
            child: const Icon(
              Icons.refresh,
              color: ColorManager.colorAppBarText,
              size: 30,
            ),
          ),
          TextButton(
            onPressed: () {
              _deleteAll();
            },
            child: const Icon(
              Icons.clear_all_rounded,
              color: ColorManager.colorAppBarText,
              size: 30,
            ),
          ),
        ],
      ),
      body: FutureBuilderWithLoader(
        future: APIService.getAllTracks(),
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

  void _deleteAll() {
    for (var track in _tracksList) {
      APIService.deleteTrack(track.trackId!);
    }
  }
}
