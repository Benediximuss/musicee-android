import 'package:flutter/material.dart';
import 'package:musicee_app/models/comment_model.dart';
import 'package:musicee_app/models/user_detail_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/services/api/api_service.dart';
import 'package:musicee_app/utils/color_manager.dart';
import 'package:musicee_app/widgets/components/elevated_icon.dart';
import 'package:musicee_app/widgets/lists/cards/comment_list_card.dart';
import 'package:musicee_app/widgets/lists/comment_list_view.dart';
import 'package:musicee_app/widgets/loaders/future_builder_with_loader.dart';

class UserCommentsScreen extends StatefulWidget {
  const UserCommentsScreen({
    super.key,
    required this.username,
  });

  final String username;

  @override
  _UserCommentsScreenState createState() => _UserCommentsScreenState();
}

class _UserCommentsScreenState extends State<UserCommentsScreen> {
  late UserDetailModel _userDetails;
  late Future<UserDetailModel> _futureModel;

  @override
  void initState() {
    super.initState();

    _futureModel = updateAndGetList();
  }

  Future<UserDetailModel> updateAndGetList() async {
    var userModel = await APIService.getUserDetails(
      widget.username,
    );

    List<CommentModel> comments = [];

    for (var comment in userModel.comments!) {
      try {
        comment.trackName =
            (await APIService.getTrackDetails(comment.trackID)).trackName;
        comments.add(comment);
      } catch (error) {
        print("3131: Deleted song comment still here amk!");
      }
    }

    userModel.comments = comments;

    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "Comments of ",
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
        ),
      ),
      body: FutureBuilderWithLoader(
        future: _futureModel,
        onComplete: (snapshot) {
          _userDetails = snapshot.data;
          if (_userDetails.comments!.isNotEmpty) {
            return CommentListView(
              commentList: _userDetails.comments!,
              pageType: PageType.USER_COMMENTS,
            );
          } else {
            return Center(
              child: _noCommentVisual(),
            );
          }
        },
      ),
    );
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
}
