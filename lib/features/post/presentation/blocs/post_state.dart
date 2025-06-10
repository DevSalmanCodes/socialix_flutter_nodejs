import 'dart:io';

import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';


abstract class PostState {}

class PostInitialState extends PostState{
  final File? file;

  PostInitialState({ this.file});

}
class PostLoadingState extends PostState {}


class PostsSuccessState extends PostState {
  final List<PostEntity>? posts;

  PostsSuccessState({this.posts});
}
class PostErrorState extends PostState {
  final String? message;

  PostErrorState(this.message);
}
