import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/lists/track_list_view.dart';

class RecommendationsList extends StatefulWidget {
  const RecommendationsList({
    Key? key,
    required this.listTitle,
    required this.futureTrackIDs,
    required this.emptyMsg,
    this.onLongPress,
    this.refreshListScreen,
    this.isPlaylist = false,
    this.deletePlaylist,
  }) : super(key: key);

  final String listTitle;
  final Future<List<String>> futureTrackIDs;
  final String emptyMsg;
  final void Function(String)? onLongPress;
  final void Function()? refreshListScreen;
  final bool isPlaylist;
  final void Function(String)? deletePlaylist;

  @override
  _RecommendationsListState createState() => _RecommendationsListState();
}

class _RecommendationsListState extends State<RecommendationsList> {
  late List<TrackModel> _tracksList;

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
              child: Builder(
                builder: (context) {
                  if (!widget.isPlaylist) {
                    return Text(
                      widget.listTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.listTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        PopupMenuButton<String>(
                          color: ColorManager.lighterSwatch.shade200,
                          elevation: 12,
                          child: const Icon(
                            Icons.more_vert,
                          ),
                          onSelected: (String item) =>
                              widget.deletePlaylist!(item),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: widget.listTitle,
                              child: Text(
                                'Delete playlist',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 250,
              child: FutureBuilderWithLoader(
                future: _getRecommendations(AuthManager.getUsername()),
                onComplete: (snapshot) {
                  _tracksList = snapshot.data as List<TrackModel>;
                  if (_tracksList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const ElevatedIcon(
                            iconData: Icons.lyrics_outlined,
                            size: 50,
                          ),
                          Text(
                            widget.emptyMsg,
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
                      tracksList: _tracksList,
                      direction: Axis.horizontal,
                      onLongPress: widget.onLongPress,
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

  Future<List<TrackModel>> _getRecommendations(String username) async {
    try {
      List<String> trackIDs = await widget.futureTrackIDs;

      List<TrackModel> tracks = [];

      try {
        for (String trackID in trackIDs) {
          tracks.add(await APIService.getTrackDetails(trackID));
        }
      } catch (error) {
        print("3131: FOR LOOP ERROR!");
      }

      return tracks;
    } catch (error) {
      return Future.error(error);
    }
  }
}
