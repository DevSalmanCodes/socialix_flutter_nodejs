import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class ToggleLike {
  final IPostRepository postRepository;
  ToggleLike({required this.postRepository});
  Future<void> call(String postId) async =>
      await postRepository.toggleLike(postId);
}
