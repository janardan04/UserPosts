part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  Usermodel usermodel;

  UserLoaded(this.usermodel);
}

class UserError extends UserState {
  final String error;

  UserError(this.error);
}
