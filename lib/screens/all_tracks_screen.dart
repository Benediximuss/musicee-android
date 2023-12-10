import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/widgets/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/track_list_view.dart';

class AllTracksScreen extends StatefulWidget {
  const AllTracksScreen({super.key});

  @override
  _AllTracksScreenState createState() => _AllTracksScreenState();
}

class _AllTracksScreenState extends State<AllTracksScreen> {
  late List<TrackModel> tracksList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Songs'),
      ),
      body: FutureBuilderWithLoader(
        future: APIService.getAllTracks(),
        onComplete: (snapshot) {
          tracksList = snapshot.data as List<TrackModel>;
          return TrackListView(tracksList: tracksList);
        },
      ),
    );
  }
}
