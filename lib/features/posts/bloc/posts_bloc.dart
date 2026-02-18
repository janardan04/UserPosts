import 'package:api_learning/features/posts/apiService/posts_api.dart';
import 'package:api_learning/features/posts/model/postmodel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsApi _postsApi;

  PostsBloc(this._postsApi) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      emit(PostsLoading());

      try {
        // List<PostModel>? postModel = await _postsApi.getPosts();
        PostModel postModel = await _postsApi.getPosts();
        emit(PostsLoaded(postModel));
      } catch (e) {
        emit(PostsError(e.toString()));
      }
    });
  }
}
