import 'package:fpdart/fpdart.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class CreatePost {
  final IPostRepository postRepository;
  CreatePost({required this.postRepository});
  Future<Either<Failure, PostEntity>> call(
    String content,
    String imagePath,
  ) async {
    try {
      final res = await postRepository.createPost(content, imagePath);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
