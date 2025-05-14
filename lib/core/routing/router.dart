import 'package:go_router/go_router.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/screens/login_screen.dart';
import 'package:socialix_flutter_nodejs/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/screens/feed_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => SignUpScreen()),
    GoRoute(path: '/feed', builder: (context, state) => FeedScreen()),
  ],
);
