part of 'delete_user_bloc.dart';

@immutable
sealed class DeleteUserState {}

final class DeleteUserInitial extends DeleteUserState {}

class DeleteSuccessfully extends DeleteUserState {
  String res;

  DeleteSuccessfully(this.res);
}

class DeleteError extends DeleteUserState {
  String? error;

  DeleteError(this.error);
}
