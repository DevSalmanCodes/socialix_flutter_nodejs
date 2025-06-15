import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/post/data/models/post_model.dart';

abstract class IPostRemoteDataSource {
  Future<List<PostModel>> getPosts(String token);
  Future<PostModel> getPostById(int id);
  Future<PostModel> createPost(String content, String imagePath);
  Future<PostModel> updatePost();
  Future<void> deletePost(String postId, String token);
  Future<void> toggleLike(String postId);
}

class PostRemoteDataSource implements IPostRemoteDataSource {
  final Dio dio;
  final AuthService authService;
  final String baseUrl = 'http://localhost:3000/api/v1/post/';

  PostRemoteDataSource({required this.dio, required this.authService});
  @override
  Future<PostModel> createPost(
    String content,
    String imagePath,
  ) async {
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
    await authService.ensureTokenIsValid();
    final res = await dio.post(
      options: Options(
        headers: {'Authorization': 'Bearer ${authService.accessToken}'},
      ),
      '$baseUrl/create',
      data: imagePath != '' ? formData : rawData,
    );
    return PostModel.fromJson(res.data['post']);
  }

  @override
  Future<void> deletePost(String postId, String token) async {
    await authService.ensureTokenIsValid();
    await dio.delete(
      '$baseUrl/$postId/delete',
      options: Options(
        headers: {'Authorization': 'Bearer ${authService.accessToken}'},
      ),
    );
  }

  @override
  Future<PostModel> getPostById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getPosts(String token) async {
    await authService.ensureTokenIsValid();
    final res = await dio.get(
      '$baseUrl/get',
      options: Options(
        headers: {'Authorization': 'Bearer ${authService.accessToken}'},
      ),
    );
    final data = res.data['data'] as List;
    return data.map((post) => PostModel.fromJson(post)).toList();
  }

  @override
  Future<PostModel> updatePost() {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleLike(String postId) async {
    await authService.ensureTokenIsValid();
    await dio.put(
      '$baseUrl/$postId/toggle-like',
      options: Options(
        headers: {'Authorization': 'Bearer ${authService.accessToken}'},
      ),
    );
  }
}
