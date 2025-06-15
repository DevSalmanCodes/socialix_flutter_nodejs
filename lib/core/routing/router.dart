import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/screens/login_screen.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/splash_screen.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/screens/feed_screen.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/screens/upload_post_screen.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/screens/profile_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),
    GoRoute(path: '/feed', builder: (context, state) => FeedScreen()),
    GoRoute(
      path: '/uploadPost',
      builder: (context, state) => UploadPostScreen(),
    ),
    GoRoute(
      path: '/profile/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId'];
        return ProfileScreen(userId: userId ?? '');
      },
    ),
  ],
);
