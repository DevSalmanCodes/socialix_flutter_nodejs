import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/features/post/data/models/like_model.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/like_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_bloc.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_event.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.theme,
    required this.post,
    required this.textTheme,
  });

  final ThemeData theme;
  final PostEntity post;
  final TextTheme textTheme;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late ValueNotifier<int> _likesCountNotifier;

  @override
  void initState() {
    super.initState();
    _likesCountNotifier = ValueNotifier(widget.post.likes!.length);
  }

  bool _isPostLikedByCurrentUser(String currentUserId) =>
      widget.post.likes!.any((like) => like.likedBy == currentUserId);

  void _onLikeTapped(String currentUserId) {
    final likes = widget.post.likes;
    _isPostLikedByCurrentUser(currentUserId)
        ? _likesCountNotifier.value -= 1
        : _likesCountNotifier.value += 1;
    _addOrRemoveUserFromLikes(likes!, currentUserId);
    context.read<PostBloc>().add(ToggleLikeEvent(postId: widget.post.postId));
  }

  void _addOrRemoveUserFromLikes(List<LikeEntity> likes, String currentUserId) {
    if (_isPostLikedByCurrentUser(currentUserId)) {
      likes.removeWhere((like) => like.likedBy == currentUserId);
    } else {
      likes.add(LikeModel(likedBy: currentUserId, postId: widget.post.postId));
    }
  }

  @override
  void dispose() {
    _likesCountNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = sl<AuthService>();
    if (authService.currentUser == null) {
      return SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: widget.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: widget.theme.primaryColor.withOpacity(0.2),
              backgroundImage: NetworkImage(
                widget.post.postedBy.avatar != ''
                    ? widget.post.postedBy.avatar!
                    : 'https://img.freepik.com/premium-vector/profile-picture-placeholder-avatar-silhouette-gray-tones-icon-colored-shapes-gradient_1076610-40164.jpg',
              ),
            ),
            title: Text(
              widget.post.postedBy.username,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: widget.textTheme.bodyLarge?.color,
              ),
            ),
            subtitle: Text(
              timeago.format(widget.post.timestamp),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: widget.textTheme.bodyMedium?.color,
              ),
            ),
            trailing: GestureDetector(
              onTapDown:
                  (details) => _showPopUpMenu(
                    details.globalPosition,
                    authService.currentUserId!,
                  ),
              child: Icon(
                PhosphorIcons.dotsThreeVertical(),
                color: widget.theme.iconTheme.color,
              ),
            ),
          ),
          if (widget.post.content != '')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.post.content,
                style: widget.textTheme.bodyLarge,
              ),
            ),

          const SizedBox(height: 10),
          if (widget.post.postImage.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.post.postImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          const SizedBox(height: 10),

          // Actions Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ValueListenableBuilder(
              valueListenable: _likesCountNotifier,
              builder:
                  (context, value, child) => Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          PhosphorIcons.heart(
                            _isPostLikedByCurrentUser(
                                  authService.currentUserId!,
                                )
                                ? PhosphorIconsStyle.fill
                                : PhosphorIconsStyle.regular,
                          ),
                          color:
                              !_isPostLikedByCurrentUser(
                                    authService.currentUserId!,
                                  )
                                  ? widget.theme.iconTheme.color
                                  : Colors.red,
                        ),
                        onPressed:
                            () => _onLikeTapped(authService.currentUserId!),
                      ),
                      Text(
                        value.toString(),
                        style: widget.textTheme.bodyMedium,
                      ),

                      const SizedBox(width: 16),
                      IconButton(
                        icon: Icon(
                          PhosphorIcons.chatCircle(),
                          color: widget.theme.iconTheme.color,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        widget.post.comments!.length.toString(),
                        style: widget.textTheme.bodyMedium,
                      ),

                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          PhosphorIcons.share(),
                          color: widget.theme.iconTheme.color,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPopUpMenu(Offset offset, String currentUserId) async {
    final top = offset.dy;
    final left = offset.dx;
    return await showMenu(
      context: context,
      items: [
        if (widget.post.postedBy.id == currentUserId) ...[
          _buildMenuItem(
            Icons.delete,
            'Delete',
            () => context.read<PostBloc>().add(
              PostDeleteEvent(postId: widget.post.postId),
            ),
          ),
          _buildMenuItem(Icons.edit, 'Edit', () {}),
        ],
      ],
      position: RelativeRect.fromLTRB(left, top, 0, 0),
    );
  }

  PopupMenuItem _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) => PopupMenuItem(
    onTap: onTap,
    child: Row(children: [Icon(icon), Text(title)]),
  );
}
