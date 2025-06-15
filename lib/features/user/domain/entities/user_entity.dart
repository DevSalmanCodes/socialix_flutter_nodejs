class UserEntity {
  final String id;
  final String username;
  final String email;
  final String? avatar;
  final String bio;
  final String coverImage;
  final String? accessToken;
  final String? refreshToken;
  final List<String>? followers;
  final List<String>? followings;
  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.bio,
    required this.coverImage,
    required this.accessToken,
    required this.refreshToken,
    required this.followers,
    required this.followings
  });
}
