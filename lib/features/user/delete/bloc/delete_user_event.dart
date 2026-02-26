part of 'delete_user_bloc.dart';

@immutable
sealed class DeleteUserEvent {}

class DeleteEvent extends DeleteUserEvent {
  int id;

  DeleteEvent({required this.id});
}
