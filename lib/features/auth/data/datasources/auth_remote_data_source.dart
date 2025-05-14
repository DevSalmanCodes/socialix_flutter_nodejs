import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  late Dio dio;
  AuthRemoteDataSource() {
    dio = Dio();
  }
  Future<UserModel> singUpUser(
    String username,
    String email,
    String password,
    String imagePath,
  ) async {
    final rawData = {
      'username': username,
      'email': email,
      'password': password,
    };
    FormData formData = FormData();
    if (imagePath != '') {
      formData = FormData.fromMap({
        ...rawData,
        'image': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
      });
    }
    final res = await dio.post(
      'http://localhost:3000/api/v1/auth/register',
      data: imagePath != '' ? formData : rawData,
    );
    if (res.statusCode == 201) {
      return UserModel.fromJson(res.data);
    } else {
      final errorMessage = res.data['error'] ?? 'Unknown error';
      throw ServerException(errorMessage);
    }
  }
}
