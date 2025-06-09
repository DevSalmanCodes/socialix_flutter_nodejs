import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class CreatePost {
  final IPostRepository postRepository;
  CreatePost({required this.postRepository});
  Future<PostEntity> call(String content, String imagePath) async =>
      postRepository.createPost(content, imagePath);
}
