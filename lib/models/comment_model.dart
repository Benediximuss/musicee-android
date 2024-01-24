class CommentModel {
  String commentID;
  String content;
  String author;
  String trackID;
  late String trackName;

  CommentModel({
    required this.commentID,
    required this.content,
    required this.author,
    required this.trackID,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json, String trackName) {
    var model = CommentModel(
      commentID: json['comment_id'],
      content: json['comment'],
      author: json['username'],
      trackID: json['track_id'],
    );
    model.trackName = trackName;
    return model;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'comment_id': commentID.trim(),
      'comment': content.trim(),
      'username': author.trim(),
      'track_id': trackID.trim(),
    };
    return map;
  }
}
