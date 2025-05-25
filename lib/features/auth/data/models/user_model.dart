import 'package:socialix_flutter_nodejs/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.avatar,
    required super.bio,
    required super.coverImage,
    required super.accessToken,
    required super.refreshToken,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String,
      coverImage: json['coverImage'] as String,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'bio': bio,
      'coverImage': coverImage,
      'accessToken': accessToken,
      'refreshRToken': refreshToken,
    };
  }
}
