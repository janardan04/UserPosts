part of 'edit_user_bloc.dart';

@immutable
sealed class EditUserEvent {}

class EditEvent extends EditUserEvent {
  int id;
  String name;
  String email;
  String gender;
  String status;

  EditEvent({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });
}
