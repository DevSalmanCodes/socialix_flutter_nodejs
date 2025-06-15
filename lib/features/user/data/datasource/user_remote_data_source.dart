import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/constants/endpoints_constants.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/user/data//models/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<UserModel> getUserDetails(String userId);
}

class UserRemoteDataSourceImpl implements IUserRemoteDataSource {
  final Dio dio;
  final AuthService authService;
  UserRemoteDataSourceImpl({required this.dio, required this.authService});
  @override
  Future<UserModel> getUserDetails(String userId) async {
    await authService.ensureTokenIsValid();
    final res = await dio.get(
      '${EndpointsConstants.baseUrl}/user/$userId/get-user',
      options: Options(
        headers: {'Authorization': 'Bearer ${authService.accessToken}'},
      ),
    );
    print(res.data);
    return UserModel.fromJson(res.data['data']);
  }
}
