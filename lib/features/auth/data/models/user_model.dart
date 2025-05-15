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
      id: json['user']['_id'] as String,
      username: json['user']['username'] as String,
      email: json['user']['email'] as String,
      avatar: json['user']['avatar'] as String,
      bio: json['user']['bio'] as String,
      coverImage: json['user']['coverImage'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['user']['refreshToken'] as String,
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
