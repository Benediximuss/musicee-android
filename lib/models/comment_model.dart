class CommentModel {
  String id;
  String content;
  String author;

  CommentModel({
    required this.id,
    required this.content,
    required this.author,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['comment_id'],
      content: json['comment_content'],
      author: json['comment_author'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'comment_id': id.trim(),
      'comment_content': id.trim(),
      'comment_author': id.trim(),
    };
    return map;
  }
}
