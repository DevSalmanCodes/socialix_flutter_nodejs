import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_secure_local_data_source.dart';
import 'package:socialix_flutter_nodejs/features/post/data/models/post_model.dart';

abstract class IPostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
  Future<PostModel> createPost(String content, String imagePath);
  Future<PostModel> updatePost();
  Future<void> deletePost(int id);
}

class PostRemoteDataSource implements IPostRemoteDataSource {
  late Dio dio;
  final AuthSecureLocalDataSource authSecureLocalDataSource;
  PostRemoteDataSource({required this.authSecureLocalDataSource}) {
    dio = Dio();
  }
  final String baseUrl = 'http://localhost:3000/api/v1/post/';
  @override
  Future<PostModel> createPost(String content, String imagePath) async {
    final token = await authSecureLocalDataSource.getToken('accessToken');
    final rawData = {'content': content};
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
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      '$baseUrl/create-post',
      data: imagePath != '' ? formData : rawData,
    );
    print(res.data);
    return PostModel.fromJson(res.data['post']);
  }

  @override
  Future<void> deletePost(int id) {
    throw UnimplementedError();
  }

  @override
  Future<PostModel> getPostById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final res = await dio.get(
      '$baseUrl/get-posts',
      options: Options(
        headers: {
          'Authorization':
              'Bearer ${await authSecureLocalDataSource.getToken('accessToken')}',
        },
      ),
    );
    print(res.data);
    return res.data['posts'].map((post) => PostModel.fromJson(post)).toList();
  }

  @override
  Future<PostModel> updatePost() {
    throw UnimplementedError();
  }
}
