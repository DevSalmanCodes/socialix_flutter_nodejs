
import 'dart:io';

import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';

abstract class CreatePostState {}

class CreatePostInitialState extends CreatePostState{
  final File? file;

  CreatePostInitialState({ this.file});

}
class CreatePostLoadingState extends CreatePostState {}
class CreatePostSuccessState extends CreatePostState {
  final PostEntity post;
  CreatePostSuccessState(this.post);
}
class CreatePostErrorState extends CreatePostState {
  final String message;
  CreatePostErrorState(this.message);
}
