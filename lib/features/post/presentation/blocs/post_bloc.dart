import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/create_post.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_event.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePost createPost;
  PostBloc({required this.createPost}) : super(PostInitial()) {
    on<UpdateImageEvent>(_onUpdateImageEvent);
    on<CreatePostEvent>(_onCreatePostEvent);
  }

  void _onCreatePostEvent(
    CreatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      final res = await createPost(event.content, event.file?.path ?? '');
      emit(PostSuccessState(res));
    } on ServerException catch (e) {
      emit(PostErrorState(e.message.toString()));
    }
  }

  void _onUpdateImageEvent(UpdateImageEvent event, Emitter<PostState> emit) {
    emit(PostInitial(file: event.file));
  }
}
