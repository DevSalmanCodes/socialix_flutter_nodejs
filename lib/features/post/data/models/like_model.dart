import 'package:socialix_flutter_nodejs/features/post/domain/entities/like_entity.dart';

class LikeModel extends LikeEntity{
   LikeModel({required super.likedBy, required super.postId});


  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      likedBy: json['likedBy'] as String,
      postId: json['postId'] as String,
    );
  }
}