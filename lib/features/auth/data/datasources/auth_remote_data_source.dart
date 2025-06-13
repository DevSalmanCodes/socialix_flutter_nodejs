import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/constants/endpoints_constants.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<UserModel> singUpUser(
    String username,
    String email,
    String password,
    String avatarPath,
  );

  Future<UserModel> loginUser(String email, String password);

  Future<UserModel> logoutUser(String token);
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});
  @override
  Future<UserModel> singUpUser(
    String username,
    String email,
    String password,
    String avatarPath,
  ) async {
    final rawData = {
      'username': username,
      'email': email,
      'password': password,
    };
    FormData formData = FormData();
    if (avatarPath != '') {
      formData = FormData.fromMap({
        ...rawData,
        'image': await MultipartFile.fromFile(
          avatarPath,
          filename: avatarPath.split('/').last,
        ),
      });
    }
    final res = await dio.post(
      '/register',
      data: avatarPath != '' ? formData : rawData,
    );
    return UserModel.fromJson(res.data['data']);
  }

  @override
  Future<UserModel> loginUser(String email, String password) async {
    final res = await dio.post(
      '${EndpointsConstants.baseUrl}/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(res.data['data']);
  }

  @override
  Future<UserModel> logoutUser(String token) async {
    final res = await dio.post(
      '/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return UserModel.fromJson(res.data['data']);
  }
}
