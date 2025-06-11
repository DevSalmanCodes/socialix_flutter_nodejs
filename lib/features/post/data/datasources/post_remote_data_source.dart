import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/features/post/data/models/post_model.dart';

abstract class IPostRemoteDataSource {
  Future<List<PostModel>> getPosts(String token);
  Future<PostModel> getPostById(int id);
  Future<PostModel> createPost(String content, String imagePath, String token);
  Future<PostModel> updatePost();
  Future<void> deletePost(String postId,String token);
  Future<void> toggleLike(String postId, String token);
}

class PostRemoteDataSource implements IPostRemoteDataSource {
  late Dio dio;
  PostRemoteDataSource() {
    dio = Dio();
  }
  final String baseUrl = 'http://localhost:3000/api/v1/post/';
  @override
  Future<PostModel> createPost(
    String content,
    String imagePath,
    String token,
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

    final res = await dio.post(
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      '$baseUrl/create',
      data: imagePath != '' ? formData : rawData,
    );
    return PostModel.fromJson(res.data['post']);
  }

  @override
  Future<void> deletePost(String postId,String token) async{
  await dio.delete('$baseUrl/$postId/delete',options: Options(headers: {
      'Authorization':'Bearer $token'
    }));
  }

  @override
  Future<PostModel> getPostById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getPosts(String token) async {
    final res = await dio.get(
      '$baseUrl/get',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final data = res.data['data'] as List;
    return data.map((post) => PostModel.fromJson(post)).toList();
  }

  @override
  Future<PostModel> updatePost() {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleLike(String postId, String token) async {
    await dio.put(
      '$baseUrl/$postId/toggle-like',
      options: Options(headers: {'Authorization': 'Beareer $token'}),
    );
  }
}
