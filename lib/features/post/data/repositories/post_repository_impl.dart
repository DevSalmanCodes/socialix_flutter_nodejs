import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/features/post/data/datasources/post_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl extends IPostRepository {
  final IPostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});
  @override
  Future<PostEntity> createPost(String content, String imagePath) {
    try {
      return remoteDataSource.createPost(content, imagePath);
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Server Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deletePost(int id) {
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> getPostById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      return await remoteDataSource.getPosts();
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Server Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PostEntity> likePost(int postId, String userId) {
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> updatePost(PostEntity post) {
    throw UnimplementedError();
  }
}
