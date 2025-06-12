import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/core/constants/app_constants.dart';
import 'package:socialix_flutter_nodejs/core/errors/exceptions.dart';
import 'package:socialix_flutter_nodejs/core/utils/show_toast.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/entities/post_entity.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/delete_post.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/get_posts.dart';
import 'package:socialix_flutter_nodejs/features/post/domain/usecases/toggle_like.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_event.dart';
import 'package:socialix_flutter_nodejs/features/post/presentation/blocs/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;
  final ToggleLike toggleLike;
  final DeletePost deletePost;
  PostBloc({
    required this.getPosts,
    required this.toggleLike,
    required this.deletePost,
  }) : super(PostInitialState()) {
    on<GetPostsEvent>(_onGetPostsEvent);
    on<ToggleLikeEvent>(_onToggleLikeEvent);
    on<PostDeleteEvent>(_onDeletePost);
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

  void _onToggleLikeEvent(
    ToggleLikeEvent event,
    Emitter<PostState> emit,
  ) async {
    final res = await toggleLike(event.postId);
    res.fold((l) => emit(PostErrorState(l.message)), (r) => null);
  }

  void _onDeletePost(PostDeleteEvent event, Emitter<PostState> emit) async {
    List<PostEntity>? posts;
    final res = await deletePost(event.postId);
    res.fold((l) => emit(PostErrorState(l.message)), (r) {
      if (state is PostsSuccessState) {
        posts = (state as PostsSuccessState).posts;
        posts?.removeWhere((post) => post.postId == event.postId);
        showToast('Post deleted successfully');
        emit(PostsSuccessState(posts: posts));
      }
    });
  }
}
