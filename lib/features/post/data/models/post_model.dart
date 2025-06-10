import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';
import 'package:socialix_flutter_nodejs/features/post/data/models/comment_model.dart';
import 'package:socialix_flutter_nodejs/features/post/data/models/like_model.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.postId,
    required super.content,
    required super.postImage,
    required super.postedBy,
    required super.likes,
    required super.comments,
    required super.timestamp,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['_id'],
      content: json['content'],
      postImage: json['postImage'] ?? '',
      postedBy: UserModel.fromJson(json['postedBy']),
      likes: List<LikeModel>.from(
        json['likes'] != null
            ? json['likes'].map((like) => LikeModel.fromJson(like))
            : [],
      ),

      comments: List<CommentModel>.from(
        json['comments'] != null
            ? json['comments'].map((comment) => CommentModel.fromJson(comment))
            : [],
      ),
      timestamp: DateTime.parse(json['createdAt']),
    );
  }
}
