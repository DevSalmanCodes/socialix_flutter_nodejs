import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/create_post.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/cubits/create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState>{
  final CreatePost createPostUseCase;
  CreatePostCubit({required this.createPostUseCase}) : super(CreatePostInitialState());

  void updateImage(String? imagePath) {
    emit(CreatePostInitialState(file: File(imagePath ?? '')));
  }

  Future<void> createPost(String content, String? imagePath) async{
    emit(CreatePostLoadingState());
    try {
      final res = await createPostUseCase(content,imagePath ??'');
      emit(CreatePostSuccessState(res));
    } on ServerException catch (e) {
      emit(CreatePostErrorState(e.message.toString()));
    }
  }

}