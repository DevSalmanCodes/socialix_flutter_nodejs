import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';

abstract class IPostRepository{
  Future<List<PostEntity>> getPosts();
  Future<PostEntity> getPostById(int id);
  Future<PostEntity> createPost(String content, String imagePath);
  Future<PostEntity> updatePost(PostEntity post);
  Future<void> deletePost(int id);
  Future<PostEntity> likePost(int postId, String userId);
}