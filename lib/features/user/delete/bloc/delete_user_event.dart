part of 'delete_user_bloc.dart';

@immutable
sealed class DeleteUserEvent {}

class DeleteEvent extends DeleteUserEvent {
  final int id;

  DeleteEvent({required this.id});
}
