import 'package:fpdart/fpdart.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/errors/failures.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/repositories/user_repository.dart';

class GetUserDetails {
  final IUserRepository userRepository;

  GetUserDetails({required this.userRepository});
  Future<Either<Failure, UserEntity>> call(String userId) async {
    try {
      final res = await userRepository.getCurrentUserDetails(userId);
      return right(res);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
