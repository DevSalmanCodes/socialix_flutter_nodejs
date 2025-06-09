import 'dart:io';

import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';

abstract class PostState {}

class PostInitial extends PostState{
  final File? file;

  PostInitial({ this.file});

}
class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {
  final PostEntity data;
  PostSuccessState(this.data);
}

class PostErrorState extends PostState {
  final String? message;

  PostErrorState(this.message);
}
