import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/comment_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/like_entity.dart';

class PostEntity {
  final String postId;
  final UserEntity postedBy;
  final String content;
  final String postImage;
  final DateTime timestamp;
  final List<LikeEntity>? likes;
  final List<CommentEntity>? comments;

  PostEntity({
    required this.postId,
    required this.postedBy,
    required this.content,
    required this.postImage,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });
}
