import 'package:flutter/material.dart';
import 'package:musicee_app/models/comment_model.dart';
import 'package:musicee_app/widgets/lists/cards/comment_list_card.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({
    super.key,
    required this.commentList,
    required this.pageType,
  });

  final List<CommentModel> commentList;
  final PageType pageType;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: commentList.length,
      itemBuilder: (context, index) {
        return CommentListCard(
          commentDetails: commentList[index],
          pageType: pageType,
        );
      },
    );
  }
}
