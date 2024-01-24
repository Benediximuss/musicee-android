import 'package:flutter/material.dart';
import 'package:musicee_app/models/comment_model.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/utils/color_manager.dart';

enum PageType {
  TRACK_COMMENTS,
  USER_COMMENTS,
}

class CommentListCard extends StatelessWidget {
  const CommentListCard({
    super.key,
    required this.commentDetails,
    required this.pageType,
  });

  final CommentModel commentDetails;
  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapCommentLogic(context);
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(
          top: 5.0,
          bottom: 15,
          left: 15.0,
          right: 15.0,
        ),
        color: ColorManager.lighterSwatch.shade100,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.black54,
                      ),
                      Text(
                        commentDetails.author,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        color: Colors.black54,
                      ),
                      Text(
                        commentDetails.trackName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                ),
                height: 2,
                color: Colors.black12,
              ),
              Text(
                commentDetails.content,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void tapCommentLogic(BuildContext context) {
    if (pageType == PageType.TRACK_COMMENTS) {
      Navigator.pushNamed(
        context,
        Routes.userProfileScreen,
        arguments: {
          'username': commentDetails.author,
          'showAppBar': true,
        },
      );
    } else {
      Navigator.pushNamed(
        context,
        Routes.songDetailsScreen,
        arguments: {
          'trackID': commentDetails.trackID,
        },
      );
    }
  }
}
