part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  List<Usermodel> users;

  UserLoaded(this.users);
}

class UserError extends UserState {
  final String error;

  UserError(this.error);
}
