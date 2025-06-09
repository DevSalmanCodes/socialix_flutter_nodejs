import 'package:socialix_flutter_nodejs/features/post/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.commentId,
    required super.commentedBy,
    required super.comment,
    required super.likes,
    required super.timestamp,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['_id'],
      commentedBy: json['commentedBy']['_id'],
      comment: json['comment'],
      likes: List<String>.from(json['likes'].map((like) => like['_id'])),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
