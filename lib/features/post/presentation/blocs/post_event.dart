import 'dart:io';

abstract class PostEvent {}

class CreatePostEvent extends PostEvent {
  final File? file;
  final String content;

  CreatePostEvent({required this.file, required this.content});
}

class UpdateImageEvent extends PostEvent {
  final File? file;

  UpdateImageEvent({required this.file});
}
class GetPostsEvent extends PostEvent {}
