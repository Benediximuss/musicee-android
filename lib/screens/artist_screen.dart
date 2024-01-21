import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/asset_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';

import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({
    super.key,
    required this.artistName,
  });

  final String artistName;

  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  late List<TrackModel> _trackList;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const ElevatedIcon(
                          svgAssetName: AssetManager.iconArtist,
                          size: 75,
                          padding: 24,
                          color: Colors.black12,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 350,
                          child: Text(
                            widget.artistName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 2,
                color: Colors.black12,
              ),
              Expanded(
                child: FutureBuilderWithLoader(
                  future: APIService.artistAllTracks(widget.artistName),
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
