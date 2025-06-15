import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/services/auth_service.dart';
import 'package:socialix_flutter_nodejs/core/services/internet_connection_checker_service.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/entities/user_entity.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/blocs/user_bloc.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/blocs/user_event.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/blocs/user_state.dart';
import 'package:socialix_flutter_nodejs/injection/service_locator.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<UserBloc>().add(GetUserDetailsEvent(widget.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final authService = sl<AuthService>();
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserLoadingState ||
                state is UserErrorState &&
                    widget.userId == authService.currentUserId) {
              return _buildProfileContent(
                authService.currentUser!,
                theme,
                textTheme,
              );
            } else if (state is UserSuccessState) {
              return _buildProfileContent(state.userEntity, theme, textTheme);
            } else if (!InternetConnectionCheckerService.isConnected) {
              return Center(child: Text('No internet connection'));
            } else {
              return Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    UserEntity user,
    ThemeData theme,
    TextTheme textTheme,
  ) => Column(
    children: [
      // Avatar
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(user.avatar.toString()),
      ),
      const SizedBox(height: 16),
      Text(
        user.username,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 4),
      Text(user.email, style: textTheme.bodyMedium),
      const SizedBox(height: 20),

      // Followers / Following / Posts
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn(
            "Followers",
            user.followers!.length.toString(),
            theme,
          ),
          _buildStatColumn(
            "Following",
            user.followings!.length.toString(),
            theme,
          ),
          _buildStatColumn("Posts", "52", theme),
        ],
      ),
      const SizedBox(height: 15.0),
      Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Edit action
              },
              label: Text(
                "Follow",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              // Logout action
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      const SizedBox(height: 24),

      // Info Card
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: theme.cardColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

          child: Column(
            children: [
              _buildRow("Phone", "+92 300 1234567", theme),
              const Divider(),
              _buildRow("Location", "Lahore, Pakistan", theme),
              const Divider(),
              _buildRow("Joined", "January 2024", theme),
            ],
          ),
        ),
      ),

      const Spacer(),

      // Buttons
    ],
  );
}

Widget _buildRow(String label, String value, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(Icons.info_outline, size: 20, color: theme.iconTheme.color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(value, style: theme.textTheme.bodyMedium),
      ],
    ),
  );
}

Widget _buildStatColumn(String label, String value, ThemeData theme) {
  return Column(
    children: [
      Text(
        value,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: theme.textTheme.bodyMedium),
    ],
  );
}
