class UserEntity {
  final String id;
  final String username;
  final String email;
  final String avatar;
  final String bio;
  final String coverImage;
  final String accessToken;
  final String refreshToken;
  UserEntity(
    {
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.bio,
    required this.coverImage,
    required this.accessToken,
    required this.refreshToken
  });
}
