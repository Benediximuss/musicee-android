import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/custom_icon_button.dart';
import 'package:musicee_app/widgets/components/custom_icon_button_mini.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/components/like_button.dart';
import 'package:musicee_app/widgets/loaders/loader_view.dart';
import 'package:musicee_app/widgets/confirm_dialog.dart';

class SongDetailScreen extends StatefulWidget {
  final String trackID;

  const SongDetailScreen({
    super.key,
    required this.trackID,
  });

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

  bool _isChanged = false;

  final _popupMenu = GlobalKey<PopupMenuButtonState>();

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, _isChanged);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_rounded,
              ),
              onPressed: () {
                _addLogic();
              },
            ),
          ],
        ),
        body: FutureBuilderWithLoader(
          future: _futureModel,
          onComplete: (snapshot) {
            _trackDetails = snapshot.data;
            _isLiked = _hasLiked();
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const ElevatedIcon(
                    iconData: Icons.music_note_rounded,
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
                          const SizedBox(height: 10),
                        ],
                      ),
                      const SizedBox(height: 30),
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
                                      fontSize: 24,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_trackDetails.trackArtist.length == 1)
                          CustomIconButtonMini(
                            buttonText: 'See artist',
                            buttonIcon: Icons.people_alt_rounded,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.artistScreen,
                                arguments: {
                                  'artistName': _trackDetails.trackArtist.first,
                                },
                              );
                            },
                          ),
                        if (_trackDetails.trackArtist.length > 1)
                          PopupMenuButton<String>(
                            key: _popupMenu,
                            color: ColorManager.colorBG,
                            offset: const Offset(-10, 0),
                            elevation: 12,
                            shape: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade700,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: CustomIconButtonMini(
                              buttonText: 'See artists',
                              buttonIcon: Icons.people_alt_rounded,
                              onPressed: () {
                                _popupMenu.currentState?.showButtonMenu();
                              },
                            ),
                            onSelected: (value) {
                              Navigator.pushNamed(
                                context,
                                Routes.artistScreen,
                                arguments: {
                                  'artistName': value,
                                },
                              );
                            },
                            itemBuilder: (context) => _trackDetails.trackArtist
                                .map(
                                  (item) => PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        CustomIconButtonMini(
                          buttonText: 'See album',
                          buttonIcon: Icons.album_rounded,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Routes.albumScreen,
                              arguments: {
                                'albumName': _trackDetails.trackAlbum,
                                'artistName': _trackDetails.trackArtist.first,
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            buttonText: 'Update',
                            buttonIcon: Icons.edit_rounded,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.updateTrackScreen,
                                arguments: {
                                  'trackID': widget.trackID,
                                },
                              );
                            },
                            borderRadius: 15,
                          ),
                          CustomIconButton(
                            buttonText: 'Delete',
                            buttonIcon: Icons.delete_rounded,
                            onPressed: () {
                              _deleteLogic(context);
                            },
                            borderRadius: 15,
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
                          const SizedBox(width: 15),
                          CustomIconButton(
                            buttonText: 'Comments',
                            buttonIcon: Icons.comment_rounded,
                            buttonValue:
                                _trackDetails.comments!.length.toString(),
                            onPressed: () {
                              _showCommentsLogic(context);
                            },
                            width: 175,
                            fontSize: 20,
                            iconSize: 25,
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
        Navigator.pop(context, true);
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
        _isChanged = true;
      });
    }).catchError((error) {
      setState(() {
        _isButtonLoading = false;
        _futureModel = updateAndGetList();
      });
      print("3131: Error liking!!! $error");
    });
  }

  void _showCommentsLogic(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.trackCommentsScreen,
      arguments: {
        'trackDetails': _trackDetails,
      },
    ).then((value) {
      if (value == true) {
        setState(() {
          _futureModel = updateAndGetList();
          _isChanged = true;
        });
      }
    }).catchError((error) {
      setState(() {
        _futureModel = updateAndGetList();
        _isChanged = true;
      });
    });
  }

  void _addLogic() {}
}
