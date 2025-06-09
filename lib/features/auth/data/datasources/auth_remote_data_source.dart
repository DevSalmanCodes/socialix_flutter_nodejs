import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_secure_local_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/models/user_model.dart';
abstract class IAuthRemoteDataSource {
  Future<UserModel> singUpUser(
    String username,
    String email,
    String password,
    String avatarPath,
  );

  Future<UserModel> loginUser(String email, String password);

  Future<UserModel> logoutUser();
}
class AuthRemoteDataSource implements IAuthRemoteDataSource{
  late Dio dio;
  final AuthSecureLocalDataSource secureLocalDataSource;
  final String baseUrl = 'http://localhost:3000/api/v1/auth/';

  AuthRemoteDataSource({required this.secureLocalDataSource}) {
    dio = Dio();
  }
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
      '$baseUrl/register',
      data: avatarPath != '' ? formData : rawData,
    );
    return UserModel.fromJson(res.data['data']);
  }
@override
  Future<UserModel> loginUser(String email, String password) async {
    final res = await dio.post(
      '$baseUrl/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(res.data['data']);
  }
@override
  Future<UserModel> logoutUser() async {
    final token = await secureLocalDataSource.getToken('accessToken');
    final res = await dio.post(
      '$baseUrl/logout',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return UserModel.fromJson(res.data['data']);
  }
}
