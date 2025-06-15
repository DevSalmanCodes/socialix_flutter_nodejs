import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/routing/router.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/core/services/internet_connection_checker_service.dart';
import 'package:socialix_flutter_nodejs/core/theme/app_theme.dart';
import 'package:socialix_flutter_nodejs/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/login_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/logout_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/domain/usecases/sign_up_user.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/data/repositories/post_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/create_post.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/delete_post.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/get_posts.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/toggle_like.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/create_post_cubit.dart';
import 'package:socialix_flutter_nodejs/features/user/data/repositories/user_repository_impl.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/usecases/get_current_user_details.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/blocs/user_bloc.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await sl<AuthService>().init();
  sl<InternetConnectionCheckerService>().init();
  final AuthRepositoryImpl authRepositoryImpl = sl<AuthRepositoryImpl>();
  final PostRepositoryImpl postRepositoryImpl = sl<PostRepositoryImpl>();
  runApp(
    MyApp(
      signUpUser: SignUpUser(authRepository: authRepositoryImpl),
      loginUser: LoginUser(authRepository: authRepositoryImpl),
      logoutUser: LogoutUser(authRepository: authRepositoryImpl),
      createPost: CreatePost(postRepository: postRepositoryImpl),
      getPosts: GetPosts(postRepository: postRepositoryImpl),
      toggleLike: ToggleLike(postRepository: postRepositoryImpl),
      deletePost: DeletePost(postRepository: postRepositoryImpl),
      getCurrentUserDetails: GetUserDetails(
        userRepository: sl<UserRepositoryImpl>(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SignUpUser signUpUser;
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final CreatePost createPost;
  final GetPosts getPosts;
  final ToggleLike toggleLike;
  final DeletePost deletePost;
  final GetUserDetails getCurrentUserDetails;
  const MyApp({
    super.key,
    required this.signUpUser,
    required this.loginUser,
    required this.logoutUser,
    required this.createPost,
    required this.getPosts,
    required this.toggleLike,
    required this.deletePost,
    required this.getCurrentUserDetails,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AuthBloc(
                signUpUser: signUpUser,
                loginUser: loginUser,
                logoutUser: logoutUser,
              ),
        ),

        BlocProvider(
          create:
              (context) => PostBloc(
                getPosts: getPosts,
                toggleLike: toggleLike,
                deletePost: deletePost,
              ),
        ),
        BlocProvider(
          create: (context) => CreatePostCubit(createPostUseCase: createPost),
        ),
        BlocProvider(
          create:
              (context) =>
                  UserBloc(getCurrentUserDetails: getCurrentUserDetails),
        ),
      ],

      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.dark,
        theme: AppThemes.lightTheme,
        routerConfig: router,
      ),
    );
  }
}
