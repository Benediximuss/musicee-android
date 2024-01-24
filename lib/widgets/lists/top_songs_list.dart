import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';

class TopSongsList extends StatefulWidget {
  const TopSongsList({
    super.key,
    required this.genreName,
    required this.tracksList,
    this.refreshListScreen,
  });

  final String genreName;
  final List<TrackModel> tracksList;
  final void Function()? refreshListScreen;

  @override
  _TopSongsListState createState() => _TopSongsListState();
}

class _TopSongsListState extends State<TopSongsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.lighterSwatch.shade200,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
              color: Colors.black12,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.genreName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: Builder(
                builder: (context) {
                  if (widget.tracksList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const ElevatedIcon(
                            iconData: Icons.lyrics_outlined,
                            size: 50,
                          ),
                          Text(
                            'No popular songs',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return TrackListView(
                      tracksList: widget.tracksList,
                      direction: Axis.horizontal,
                      refreshListScreen: widget.refreshListScreen,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
