import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class GetPosts {
  final IPostRepository postRepository;

GetPosts({required this.postRepository});

  Future<List<PostEntity>> call() async => await postRepository.getPosts();
}
