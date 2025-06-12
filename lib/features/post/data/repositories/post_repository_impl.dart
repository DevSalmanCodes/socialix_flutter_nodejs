import 'package:dio/dio.dart';
import 'package:socialix_flutter_nodejs/core/constants/app_constants.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/post/data/datasources/post_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl extends IPostRepository {
  final IPostRemoteDataSource remoteDataSource;
  final AuthService authService;
  PostRepositoryImpl({
    required this.authService,
    required this.remoteDataSource,
  });
  @override
  Future<PostEntity> createPost(String content, String imagePath) async {
    try {
      return await remoteDataSource.createPost(
        content,
        imagePath,
        authService.currentUser!.accessToken!,
      );
    } on DioException catch (e) {
      _clearUserIfTokenExpired(e);
      throw ServerException(e.response?.data['message'] ?? 'Unexpected Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await remoteDataSource.deletePost(
        postId,
        authService.currentUser!.accessToken!,
      );
    } on DioException catch (e) {
      _clearUserIfTokenExpired(e);
      throw ServerException(e.response?.data['message'] ?? 'Unexpected Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PostEntity> getPostById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      return await remoteDataSource.getPosts(
        authService.currentUser!.accessToken!,
      );
    } on DioException catch (e) {
      _clearUserIfTokenExpired(e);
      throw ServerException(e.response?.data['message'] ?? 'Unexpected Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> toggleLike(String postId) async {
    try {
      return await remoteDataSource.toggleLike(
        postId,
        authService.currentUser!.accessToken!,
      );
    } on DioException catch (e) {
      _clearUserIfTokenExpired(e);
      throw ServerException(e.response?.data['message'] ?? 'Unexpected Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PostEntity> updatePost(PostEntity post) {
    throw UnimplementedError();
  }

  void _clearUserIfTokenExpired(DioException e) async {
    final errorMessage = e.response?.data['message'];
    if (errorMessage == AppConstants.tokenExpired) {
      await authService.clearUser();
    }
  }
}
