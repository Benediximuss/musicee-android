import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/asset_manager.dart';
import 'package:musicee_app/widgets/delete_confirm_dialog.dart';
import 'package:musicee_app/widgets/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/loader_view.dart';

class SongDetailScreen extends StatefulWidget {
  final String trackID;

  const SongDetailScreen({Key? key, required this.trackID}) : super(key: key);

  @override
  _SongDetailScreenState createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  late TrackModel _trackDetails;

  late Future<TrackModel> _futureModel;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _futureModel = updateAndGetList();
  }

  Future<TrackModel> updateAndGetList() async {
    return APIService.getTrackDetails(widget.trackID);
  }

  @override
  Widget build(BuildContext context) {
    return LoaderView(
      condition: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Song Details',
          ),
        ),
        body: FutureBuilderWithLoader(
          future: _futureModel,
          onComplete: (snapshot) {
            _trackDetails = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      AssetManager.placeholderAlbumArt,
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      _trackDetails.trackName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      _trackDetails.trackArtist.join(', '),
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.updateTrackScreen,
                            arguments: {
                              'trackID': widget.trackID,
                            },
                          );
                        },
                        child: const Text('Update'),
                      ),
                    ),
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          _deleteLogic(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _deleteLogic(final context) async {
    if (await deleteConfirmDialog(context)) {
      setState(() {
        _isLoading = true;
      });
      APIService.deleteTrack(widget.trackID).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value != null) {
          print("3131: ZORTZORT OLDU");
        } else {
          Navigator.pop(context);
        }
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        print("3131: Error deleting!!! $error");
      });
    }
  }
}
