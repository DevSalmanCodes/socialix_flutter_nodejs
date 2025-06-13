import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:socialix_flutter_nodejs/core/constants/app_constants.dart';
import 'package:socialix_flutter_nodejs/core/utils/show_toast.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_event.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_state.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.plus()),
            onPressed: () => context.push('/uploadPost'),
          ),
        ],
      ),
      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostErrorState) {
            if (state.message == AppConstants.tokenExpired ||
                state.message == 'jwt expired') {
              showToast(AppConstants.sessionExpired);
              context.pushReplacement('/login');
            } else {
              showToast(state.message.toString());
            }
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is PostsSuccessState) {
            final posts = state.posts;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posts!.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(theme: theme, post: post, textTheme: textTheme);
              },
            );
          } else if (state is PostInitialState) {
            return const Center(child: Text('No posts available'));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
