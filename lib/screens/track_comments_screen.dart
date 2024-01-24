import 'package:flutter/material.dart';
import 'package:musicee_app/models/track_model.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/services/auth/auth_manager.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/utils/theme_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/cards/comment_list_card.dart';
import 'package:musicee_app/widgets/lists/comment_list_view.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';
import 'package:musicee_app/widgets/loaders/loader_view.dart';

class TrackCommentsScreen extends StatefulWidget {
  const TrackCommentsScreen({
    super.key,
    required this.trackDetails,
  });

  final TrackModel trackDetails;

  @override
  _TrackCommentsScreenState createState() => _TrackCommentsScreenState();
}

class _TrackCommentsScreenState extends State<TrackCommentsScreen> {
  final _commentController = TextEditingController();
  final _commentFocus = FocusNode();

  late TrackModel _trackDetails;
  late Future<TrackModel> _futureModel;

  bool _error = false;
  final String _errorMesage = 'Error occured, try again!';

  bool _isLoading = false;

  bool _isChanged = false;

  @override
  void initState() {
    super.initState();

    _futureModel = updateAndGetList();
  }

  Future<TrackModel> updateAndGetList() async {
    return APIService.getTrackDetails(
      widget.trackDetails.trackId!,
      getGenre: true,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }

  bool _validateInput() {
    if (_commentController.text.isEmpty) {
      setState(() {
        _commentFocus.requestFocus();
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    _trackDetails = widget.trackDetails;
    return LoaderView(
        condition: _isLoading,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Comments'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, _isChanged);
                },
              )),
          body: FutureBuilderWithLoader(
            future: _futureModel,
            onComplete: (snapshot) {
              _trackDetails = snapshot.data;
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _commentController,
                                  focusNode: _commentFocus,
                                  minLines: 1,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    error: _error ? Text(_errorMesage!) : null,
                                    filled: true,
                                    fillColor:
                                        ColorManager.lighterSwatch.shade100,
                                    labelText: 'Write a comment',
                                    icon: const Icon(Icons.comment),
                                    border: ThemeManager.buildFormOutline(
                                      _commentController,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              PostButton(
                                onPressed: () {
                                  if (_validateInput()) {
                                    _postCommentLogic();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        if (_trackDetails.comments!.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 2,
                            color: Colors.black26,
                          ),
                        Expanded(
                          child: Builder(
                            builder: (context) {
                              if (_trackDetails.comments!.isEmpty) {
                                return _noCommentVisual();
                              } else {
                                return CommentListView(
                                  commentList: _trackDetails.comments!,
                                  pageType: PageType.TRACK_COMMENTS,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Container _noCommentVisual() {
    return Container(
      color: ColorManager.colorBG,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ElevatedIcon(
            iconData: Icons.lyrics_outlined,
            size: 50,
          ),
          const SizedBox(height: 30),
          Text(
            'No comments here!',
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

  void _postCommentLogic() {
    setState(() {
      _isLoading = true;
    });

    APIService.postComment(
      AuthManager.getUsername(),
      _trackDetails.trackId!,
      _commentController.text,
    ).then((value) async {
      setState(() {
        _error = false;
        _isChanged = true;
        _futureModel = updateAndGetList();
        _isLoading = false;
        _commentController.clear();
      });
    }).catchError((error) {
      setState(() {
        _error = true;
        _futureModel = updateAndGetList();
        _isLoading = false;
      });
    });
  }
}

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(25.0),
      child: Ink(
        width: 50.0,
        height: 50.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorManager.colorPrimary,
        ),
        child: const Center(
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
