part of 'add_user_bloc.dart';

@immutable
sealed class AddUserEvent {}

class AddNewUserEvent extends AddUserEvent {
  String name;
  String email;
  String gender;
  String status;

  AddNewUserEvent({
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });
}

class RefreshPageEvent extends AddUserEvent {}
