import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  late Dio dio;
  final String baseUrl = 'http://localhost:3000/api/v1/auth/';

  AuthRemoteDataSource() {
    dio = Dio();
  }

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
      '$baseUrl/register',
      data: avatarPath != '' ? formData : rawData,
    );
    if (res.statusCode == 201) {
      return UserModel.fromJson(res.data['data']);
    } else {
      final errorMessage = res.data['message'] ?? 'Unknown error';
      throw ServerException(errorMessage);
    }
  }

  Future<UserModel> loginUser(String email, String password) async {
    final res = await dio.post(
      '$baseUrl/login',
      data: {'email': email, 'password': password},
    );
  return UserModel.fromJson(res.data['data']);
  }

  Future<void> logoutUser() async {
    await dio.post('$baseUrl/logout');
  }
}
