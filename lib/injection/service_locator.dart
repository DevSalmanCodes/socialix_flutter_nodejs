import 'package:dio/dio.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:socialix_flutter_nodejs/core/network/dio_client.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/post/data/datasources/post_remote_data_source.dart';
import 'package:socialix_flutter_nodejs/features/post/data/repositories/post_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());

  sl.registerLazySingleton<AuthRemoteDataSourceImpl>(
    () => AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSourceImpl>(),
      authService: sl<AuthService>(),
    ),
  );
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(dio: sl<Dio>(), authService: sl<AuthService>()),
  );
  sl.registerLazySingleton<PostRepositoryImpl>(
    () => PostRepositoryImpl(
      remoteDataSource: sl<PostRemoteDataSource>(),
      authService: sl<AuthService>(),
    ),
  );
  sl.registerLazySingleton<AuthService>(() => AuthService(dio: sl<Dio>()));
  sl.registerLazySingleton<Dio>(() => DioClient.createDio());
}
