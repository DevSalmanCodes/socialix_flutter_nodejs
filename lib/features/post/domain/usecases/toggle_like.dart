import 'package:fpdart/fpdart.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class ToggleLike {
  final IPostRepository postRepository;
  ToggleLike({required this.postRepository});
 Future<Either<Failure,void>> call(String postId)async{
  try {
    await postRepository.toggleLike(postId);
    return right(null);
  }on ServerException catch (e) {
    return left(ServerFailure(e.message.toString()));
  }catch(e){
    return left(ServerFailure(e.toString()));
  }
 }
}
