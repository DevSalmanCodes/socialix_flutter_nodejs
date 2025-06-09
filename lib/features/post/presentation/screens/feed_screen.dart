import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:socialix_flutter_nodejs/core/utils/show_toast.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_event.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_state.dart';

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
            showToast(state.message.toString());
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostSuccessState) {
            final posts = state.data as List<PostEntity>;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: theme.primaryColor.withOpacity(0.2),
                          child: Text(
                            'U',
                            style: GoogleFonts.poppins(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          'Username',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: textTheme.bodyLarge?.color,
                          ),
                        ),
                        subtitle: Text(
                          '2 hours ago',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: textTheme.bodyMedium?.color,
                          ),
                        ),
                        trailing: Icon(
                          PhosphorIcons.dotsThreeVertical(),
                          color: theme.iconTheme.color,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          posts[index].content,
                          style: textTheme.bodyLarge,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Actions Row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                PhosphorIcons.heart(),
                                color: theme.iconTheme.color,
                              ),
                              onPressed: () {},
                            ),
                            Text('24', style: textTheme.bodyMedium),

                            const SizedBox(width: 16),
                            IconButton(
                              icon: Icon(
                                PhosphorIcons.chatCircle(),
                                color: theme.iconTheme.color,
                              ),
                              onPressed: () {},
                            ),
                            Text('8', style: textTheme.bodyMedium),

                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                PhosphorIcons.share(),
                                color: theme.iconTheme.color,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is PostInitial) {
            return const Center(child: Text('No posts available'));
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
