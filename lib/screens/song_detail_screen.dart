import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/widgets/components/custom_icon_button.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/components/like_button.dart';
import 'package:musicee_app/widgets/loaders/loader_view.dart';
import 'package:musicee_app/widgets/confirm_dialog.dart';

class SongDetailScreen extends StatefulWidget {
  final String trackID;

  const SongDetailScreen({Key? key, required this.trackID}) : super(key: key);

  @override
  _SongDetailScreenState createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  late TrackModel _trackDetails;
  late Future<TrackModel> _futureModel;

  // UI Logic
  bool _isLoading = false;
  bool _isButtonLoading = false;
  late bool _isLiked;

  @override
  void initState() {
    super.initState();

    _futureModel = updateAndGetList();
  }

  Future<TrackModel> updateAndGetList() async {
    return APIService.getTrackDetails(
      widget.trackID,
      getGenre: true,
    );
  }

  bool _hasLiked() {
    return _trackDetails.trackLikeList!.contains(AuthManager.getUsername());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderView(
      condition: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Song Details'),
        ),
        body: FutureBuilderWithLoader(
          future: _futureModel,
          onComplete: (snapshot) {
            _trackDetails = snapshot.data;
            _isLiked = _hasLiked();
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.music_note_rounded,
                          size: 100,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            _trackDetails.trackName,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                              _trackDetails.trackArtist.join(', '),
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.album_rounded,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      overflow: TextOverflow.fade,
                                      _trackDetails.trackAlbum,
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_rounded,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    _trackDetails.trackReleaseYear.toString(),
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.library_music_rounded,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      _trackDetails.genre!,
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.thumb_up,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    _trackDetails.trackLikeList!.length
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            buttonText: 'Update',
                            buttonIcon: Icons.edit_rounded,
                            height: 60,
                            width: 150,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.updateTrackScreen,
                                arguments: {
                                  'trackID': widget.trackID,
                                },
                              );
                            },
                          ),
                          CustomIconButton(
                            buttonText: 'Delete',
                            buttonIcon: Icons.delete_rounded,
                            height: 60,
                            width: 150,
                            onPressed: () {
                              _deleteLogic(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LikeButton(
                            isLoading: _isButtonLoading,
                            isLiked: _isLiked,
                            onPressed: _likeLogic,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _deleteLogic(final context) async {
    if (await confirmDialog(
      context: context,
      warningText: 'Are you sure you want to delete this song?',
      actionButtonText: 'Delete',
    )) {
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

  void _likeLogic() async {
    if (_isLiked &&
        !(await confirmDialog(
          context: context,
          warningText: 'Are you sure you want to unlike this song?',
          actionButtonText: 'Unlike',
        ))) {
      return;
    }

    setState(() {
      _isButtonLoading = true;
    });

    APIService.likeTrack(AuthManager.getUsername(), widget.trackID)
        .then((value) {
      setState(() {
        _isButtonLoading = false;
        _futureModel = updateAndGetList();
      });
    }).catchError((error) {
      setState(() {
        _isButtonLoading = false;
        _futureModel = updateAndGetList();
      });
      print("3131: Error liking!!! $error");
    });
  }
}
