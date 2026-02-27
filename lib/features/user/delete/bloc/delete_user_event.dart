part of 'delete_user_bloc.dart';

sealed class DeleteUserEvent {}

class DeleteEvent extends DeleteUserEvent {
  int id;

  DeleteEvent({required this.id});
}
