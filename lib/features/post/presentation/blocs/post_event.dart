import 'dart:io';

abstract class PostEvent {}



class UpdateImageEvent extends PostEvent {
  final File? file;

  UpdateImageEvent({required this.file});
}
class GetPostsEvent extends PostEvent {}
class ToggleLikeEvent extends PostEvent {
  final String postId;

  ToggleLikeEvent({required this.postId});
  
}
class PostDeleteEvent extends PostEvent{
 final String postId;

  PostDeleteEvent({required this.postId});

}
