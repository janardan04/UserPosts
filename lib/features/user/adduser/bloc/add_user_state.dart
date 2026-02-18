part of 'add_user_bloc.dart';

@immutable
sealed class AddUserState {}

final class AddUserInitial extends AddUserState {}

class AddUserAddingState extends AddUserState {}

class AddUserSuccessState extends AddUserState {}

class AddUserErrorState extends AddUserState {
  final String error;

  AddUserErrorState(this.error);
}
