import 'package:flutter/material.dart';
import 'package:musicee_app/models/playlist_model.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/recommendations_list.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class UserPlaylistsScreen extends StatefulWidget {
  const UserPlaylistsScreen({
    super.key,
    required this.username,
    required this.isSelf,
  });

  final String username;
  final bool isSelf;

  @override
  _UserPlaylistsScreenState createState() => _UserPlaylistsScreenState();
}

class _UserPlaylistsScreenState extends State<UserPlaylistsScreen> {
  late UserDetailModel _userModel;

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            if (widget.isSelf) {
              return const Text('Your playlists');
            } else {
              return RichText(
                text: TextSpan(
                  text: "Playlists of ",
                  style: const TextStyle(
                      color: ColorManager.colorAppBarText, fontSize: 20),
                  children: [
                    TextSpan(
                      text: widget.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
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
        ],
      ),
      body: FutureBuilderWithLoader(
        future: _getUserDetails(widget.username),
        onComplete: (snapshot) {
          _userModel = snapshot.data as UserDetailModel;
          if (_userModel.playlists!.isNotEmpty) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _userModel.playlists!.length,
              itemBuilder: (context, index) => SizedBox(
                height: 350,
                child: RecommendationsList(
                  listTitle: _userModel.playlists![index].listName,
                  futureTrackIDs:
                      _getListTrackIDs(_userModel.playlists![index]),
                  emptyMsg: 'No songs in this playlist!',
                  refreshListScreen: _refresh,
                  isPlaylist: true,
                  onLongPress: (trackID) {
                    _removeTrack(
                      trackID: trackID,
                      playlistName: _userModel.playlists![index].listName,
                      username: _userModel.username!,
                    );
                  },
                  deletePlaylist: (listName) {
                    _deletePlaylist(
                      playlistName: listName,
                      username: _userModel.username!,
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ElevatedIcon(
                    iconData: Icons.lyrics_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'No playlists!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: widget.isSelf
          ? FloatingActionButton(
              onPressed: () {
                _showCreatePlaylistDialog();
              },
              tooltip: 'Create playlist',
              foregroundColor: ColorManager.colorAppBarText,
              backgroundColor: ColorManager.colorPrimary,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 35,
              ),
            )
          : null,
    );
  }

  Future<List<String>> _getListTrackIDs(PlaylistModel playlist) async {
    return playlist.trackIDs;
  }

  Future<UserDetailModel> _getUserDetails(String username) async {
    try {
      final userModel = await APIService.getUserDetails(username);
      return userModel;
    } catch (error) {
      return Future.error(error);
    }
  }

  void _removeTrack({
    required String trackID,
    required String playlistName,
    required String username,
  }) {
    print("3131: Removing '$trackID' from $playlistName! by $username");

    APIService.addPlaylist(username, playlistName, trackID).then(
      (value) {
        setState(() {});
      },
    );
  }

  void _deletePlaylist({
    required String playlistName,
    required String username,
  }) {
    print("3131: Deleting playlist '$playlistName' by $username");

    APIService.deletePlaylist(username, playlistName).then(
      (value) {
        setState(() {});
      },
    );
  }

  void _createPlaylist() {
    print("3131: create playlist!");
  }

  final TextEditingController _playlistNameController = TextEditingController();

  void _onSubmit(String userInputName) async {
    print('3131: Created Playlist Name: $userInputName');

    for (int i = 0; i < 2; i++) {
      await APIService.addPlaylist(
        _userModel.username!,
        userInputName,
        'dummy',
      );
    }

    _refresh();
  }

  void _showCreatePlaylistDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Playlist'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _playlistNameController,
                decoration: const InputDecoration(labelText: 'Playlist Name'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _playlistNameController.clear();
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _onSubmit(_playlistNameController.text);
                      _playlistNameController.clear();
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
