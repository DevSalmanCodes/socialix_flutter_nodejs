import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/create_post.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/get_posts.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_event.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final CreatePost createPost;
  final GetPosts getPosts;
  PostBloc({required this.createPost, required this.getPosts})
    : super(PostInitialState()) {
    on<UpdateImageEvent>(_onUpdateImageEvent);
    on<CreatePostEvent>(_onCreatePostEvent);
    on<GetPostsEvent>(_onGetPostsEvent);
  }

  void _onCreatePostEvent(
    CreatePostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoadingState());
    try {
      final newPost = await createPost(event.content, event.file?.path ?? '');
      if (state is PostsSuccessState) {
        final currentPosts = (state as PostsSuccessState).posts;
        final updatedPosts = [newPost, ...currentPosts!];
        emit(PostsSuccessState(posts: updatedPosts));
      } else {
        emit(PostsSuccessState(posts: [newPost]));
      }
    } on ServerException catch (e) {
      emit(PostErrorState(e.message.toString()));
    }
  }

  void _onUpdateImageEvent(UpdateImageEvent event, Emitter<PostState> emit) {
    emit(PostInitialState(file: event.file));
  }

  void _onGetPostsEvent(GetPostsEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    try {
      final posts = await getPosts();
      emit(PostsSuccessState(posts: posts));
    } on ServerException catch (e) {
      emit(PostErrorState(e.message.toString()));
    }
  }
}
