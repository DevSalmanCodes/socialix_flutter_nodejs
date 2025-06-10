import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage(
                post.postedBy.avatar != ''
                    ? post.postedBy.avatar!
                    : 'https://img.freepik.com/premium-vector/profile-picture-placeholder-avatar-silhouette-gray-tones-icon-colored-shapes-gradient_1076610-40164.jpg',
              ),
            ),
            title: Text(
              post.postedBy.username,
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
            child: Text(post.content, style: textTheme.bodyLarge),
          ),
    
          const SizedBox(height: 10),
          if (post.postImage.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: post.postImage,
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
                Text(
                  post.likes!.length.toString(),
                  style: textTheme.bodyMedium,
                ),
    
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    PhosphorIcons.chatCircle(),
                    color: theme.iconTheme.color,
                  ),
                  onPressed: () {},
                ),
                Text(
                  post.comments!.length.toString(),
                  style: textTheme.bodyMedium,
                ),
    
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
  }
}