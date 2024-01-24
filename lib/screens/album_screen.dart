import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({
    super.key,
    required this.albumName,
    required this.artistName,
  });

  final String albumName;
  final String artistName;

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late List<TrackModel> _trackList;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const ElevatedIcon(
                          iconData: Icons.album_rounded,
                          padding: 24,
                          size: 75,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: 350,
                            child: Text(
                              widget.albumName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )),
                        const SizedBox(height: 5),
                        const Text(
                          'by',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            widget.artistName,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                color: Colors.black12,
              ),
              Expanded(
                child: FutureBuilderWithLoader(
                  future: APIService.albumAllTracks(widget.albumName),
                  onComplete: (snapshot) {
                    _trackList = snapshot.data as List<TrackModel>;
                    return TrackListView(
                      tracksList: _trackList,
                      refreshListScreen: _refresh,
                      direction: Axis.vertical,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
