import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class DeletePost {
  final IPostRepository postRepository;
  DeletePost({required this.postRepository});

  Future<void> call(String postId) async =>
      await postRepository.deletePost(postId);
}
