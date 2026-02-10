part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final PostModel postModel;

  PostsLoaded(this.postModel);
}

class PostsError extends PostsState {
  final String error;

  PostsError(this.error);
}
